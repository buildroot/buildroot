# SPDX-License-Identifier: GPL-2.0
# SPDX-License-Identifier: ISC

import os

import pexpect
import pexpect.replwrap
import time

import infra

BR_PROMPT = '[BRTEST# '
BR_CONTINUATION_PROMPT = '[BRTEST+ '


def _repl_sh_child(child, orig_prompt, extra_init_cmd):
    """Wrap the shell prompt to handle command output
    Based on pexpect.replwrap._repl_sh() (ISC licensed)
    https://github.com/pexpect/pexpect/blob/aa989594e1e413f45c18b26ded1783f7d5990fe5/pexpect/replwrap.py#L115
    """

    # If the user runs 'env', the value of PS1 will be in the output. To avoid
    # replwrap seeing that as the next prompt, we'll embed the marker characters
    # for invisible characters in the prompt; these show up when inspecting the
    # environment variable, but not when bash displays the prompt.
    non_printable_insert = '\\[\\]'
    ps1 = BR_PROMPT[:5] + non_printable_insert + BR_PROMPT[5:]
    ps2 = (BR_CONTINUATION_PROMPT[:5] + non_printable_insert +
           BR_CONTINUATION_PROMPT[5:])
    prompt_change = "PS1='{0}' PS2='{1}' PROMPT_COMMAND=''".format(ps1, ps2)
    # Note: this will run various commands, each with the default timeout defined
    # when qemu was spawned.
    return pexpect.replwrap.REPLWrapper(
            child,
            orig_prompt,
            prompt_change,
            new_prompt=BR_PROMPT,
            continuation_prompt=BR_CONTINUATION_PROMPT,
            extra_init_cmd=extra_init_cmd
        )


class Emulator(object):

    def __init__(self, builddir, downloaddir, logtofile, timeout_multiplier):
        self.qemu = None
        self.repl = None
        self.builddir = builddir
        self.downloaddir = downloaddir
        self.logfile = infra.open_log_file(builddir, "run", logtofile)
        # We use elastic runners on the cloud to runs our tests. Those runners
        # can take a long time to run the emulator. Use a timeout multiplier
        # when running the tests to avoid sporadic failures.
        self.timeout_multiplier = timeout_multiplier

    # Start Qemu to boot the system
    #
    # arch: Qemu architecture to use
    #
    # kernel: path to the kernel image, or the special string
    # 'builtin'. 'builtin' means a pre-built kernel image will be
    # downloaded from ARTIFACTS_URL and suitable options are
    # automatically passed to qemu and added to the kernel cmdline. So
    # far only armv5, armv7 and i386 builtin kernels are available.
    # If None, then no kernel is used, and we assume a bootable device
    # will be specified.
    #
    # kernel_cmdline: array of kernel arguments to pass to Qemu -append option
    #
    # options: array of command line options to pass to Qemu
    #
    def boot(self, arch, kernel=None, kernel_cmdline=None, options=None):
        if arch in ["armv7", "armv5"]:
            qemu_arch = "arm"
        else:
            qemu_arch = arch

        qemu_cmd = ["qemu-system-{}".format(qemu_arch),
                    "-serial", "stdio",
                    "-display", "none",
                    "-m", "256"]

        if options:
            qemu_cmd += options

        if kernel_cmdline is None:
            kernel_cmdline = []

        if kernel:
            if kernel == "builtin":
                if arch in ["armv7", "armv5"]:
                    kernel_cmdline.append("console=ttyAMA0")

                if arch == "armv7":
                    kernel = infra.download(self.downloaddir,
                                            "kernel-vexpress-5.10.202")
                    dtb = infra.download(self.downloaddir,
                                         "vexpress-v2p-ca9-5.10.202.dtb")
                    qemu_cmd += ["-dtb", dtb]
                    qemu_cmd += ["-M", "vexpress-a9"]
                elif arch == "armv5":
                    kernel = infra.download(self.downloaddir,
                                            "kernel-versatile-5.10.202")
                    dtb = infra.download(self.downloaddir,
                                         "versatile-pb-5.10.202.dtb")
                    qemu_cmd += ["-dtb", dtb]
                    qemu_cmd += ["-M", "versatilepb"]
                    qemu_cmd += ["-device", "virtio-rng-pci"]

            qemu_cmd += ["-kernel", kernel]

        if kernel_cmdline:
            qemu_cmd += ["-append", " ".join(kernel_cmdline)]

        self.logfile.write(f"> host cpu count: {os.cpu_count()}\n")
        ldavg = os.getloadavg()
        ldavg_str = f"{ldavg[0]:.2f}, {ldavg[1]:.2f}, {ldavg[2]:.2f}"
        self.logfile.write(f"> host loadavg: {ldavg_str}\n")
        self.logfile.write(f"> timeout multiplier: {self.timeout_multiplier}\n")
        self.logfile.write(f"> emulator using {qemu_cmd[0]} version:\n")
        host_bin = os.path.join(self.builddir, "host", "bin")
        br_path = host_bin + os.pathsep + os.environ["PATH"]
        qemu_env = {"QEMU_AUDIO_DRV": "none",
                    "PATH": br_path}
        pexpect.run(f"{qemu_cmd[0]} --version",
                    encoding='utf-8',
                    logfile=self.logfile,
                    env=qemu_env)
        self.logfile.write("> starting qemu with '%s'\n" % " ".join(qemu_cmd))
        self.qemu = pexpect.spawn(qemu_cmd[0], qemu_cmd[1:],
                                  timeout=5 * self.timeout_multiplier,
                                  encoding='utf-8',
                                  codec_errors='replace',
                                  env=qemu_env)
        # We want only stdout into the log to avoid double echo
        self.qemu.logfile_read = self.logfile

    # Wait for the login prompt to appear, and then login as root with
    # the provided password, or no password if not specified.
    def login(self, password=None, timeout=60):
        # The login prompt can take some time to appear when running multiple
        # instances in parallel, so set the timeout to a large value
        index = self.qemu.expect(["buildroot login:", pexpect.TIMEOUT],
                                 timeout=timeout * self.timeout_multiplier)
        if index != 0:
            self.logfile.write("==> System does not boot")
            raise SystemError("System does not boot")

        self.qemu.sendline("root")
        if password:
            self.qemu.expect("Password:")
            self.qemu.sendline(password)

        self.connect_shell()

        output, exit_code = self.run(f"date -s @{int(time.time())}")
        if exit_code:
            raise SystemError("Cannot set date in virtual machine")

    def connect_shell(self):
        extra_init_cmd = " && ".join([
            'export PAGER=cat',
            'dmesg -n 1',
            # Prevent the shell from wrapping the commands at 80 columns.
            'stty columns 29999',
            # Fix the prompt of any subshells that get run
            'printf "%s\n"  "PS1=\'$PS1\'" "PS2=\'$PS2\'" "PROMPT_COMMAND=\'\'" >>/etc/profile'
        ])
        self.repl = _repl_sh_child(self.qemu, '# ', extra_init_cmd)
        if not self.repl:
            raise SystemError("Cannot initialize REPL prompt")

    # Run the given 'cmd' with a 'timeout' on the target
    # return a tuple (output, exit_code)
    def run(self, cmd, timeout=-1):
        if timeout != -1:
            timeout *= self.timeout_multiplier
        output = self.repl.run_command(cmd, timeout=timeout)
        # Remove double carriage return from qemu stdout so str.splitlines()
        # works as expected.
        output = output.replace("\r\r", "\r").splitlines()[1:]

        exit_code = self.repl.run_command("echo $?")
        exit_code = self.qemu.before.splitlines()[2]
        exit_code = int(exit_code)

        return output, exit_code

    def stop(self):
        if self.qemu is None:
            return
        self.qemu.terminate(force=True)
