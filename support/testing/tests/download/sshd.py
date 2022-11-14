import os
import shutil
import subprocess
from unittest import SkipTest

# subprocess does not kill the child daemon when a test case fails by raising
# an exception. So use pexpect instead.
import pexpect

import infra


SSHD_PORT_INITIAL = 2222
SSHD_PORT_LAST = SSHD_PORT_INITIAL + 99
SSHD_PATH = "/usr/sbin/sshd"
SSHD_HOST_DIR = "host"

# SSHD_KEY_DIR is where the /etc/ssh/ssh_host_*_key files go
SSHD_KEY_DIR = os.path.join(SSHD_HOST_DIR, "etc/ssh")
SSHD_KEY = os.path.join(SSHD_KEY_DIR, "ssh_host_ed25519_key")

# SSH_CLIENT_KEY_DIR is where the client id_rsa key and authorized_keys files go
SSH_CLIENT_KEY_DIR = os.path.join(SSHD_HOST_DIR, "home/br-user/ssh")
SSH_CLIENT_KEY = os.path.join(SSH_CLIENT_KEY_DIR, "id_rsa")
SSH_AUTH_KEYS_FILE = os.path.join(SSH_CLIENT_KEY_DIR, "authorized_keys")


class OpenSSHDaemon():

    def __init__(self, builddir, logtofile):
        """
        Start an OpenSSH SSH Daemon

        In order to support test cases in parallel, select the port the
        server will listen to in runtime. Since there is no reliable way
        to allocate the port prior to starting the server (another
        process in the host machine can use the port between it is
        selected from a list and it is really allocated to the server)
        try to start the server in a port and in the case it is already
        in use, try the next one in the allowed range.
        """
        self.daemon = None
        self.port = None

        self.logfile = infra.open_log_file(builddir, "sshd", logtofile)

        server_keyfile = os.path.join(builddir, SSHD_KEY)
        auth_keys_file = os.path.join(builddir, SSH_AUTH_KEYS_FILE)
        daemon_cmd = [SSHD_PATH,
                      "-D",  # or use -ddd to debug
                      "-e",
                      "-h", server_keyfile,
                      "-f", "/dev/null",
                      "-o", "ListenAddress=localhost",
                      "-o", "PidFile=none",
                      "-o", "AuthenticationMethods=publickey",
                      "-o", "StrictModes=no",
                      "-o", "Subsystem=sftp internal-sftp",
                      "-o", "AuthorizedKeysFile={}".format(auth_keys_file)]
        for port in range(SSHD_PORT_INITIAL, SSHD_PORT_LAST + 1):
            cmd = daemon_cmd + ["-p", "{}".format(port)]
            self.logfile.write(
                "> starting sshd with '{}'\n".format(" ".join(cmd)))
            try:
                self.daemon = pexpect.spawn(cmd[0], cmd[1:], logfile=self.logfile,
                                            encoding='utf-8')
            except pexpect.exceptions.ExceptionPexpect as e:
                self.logfile.write("> {} - skipping\n".format(e))
                raise SkipTest(str(e))

            ret = self.daemon.expect([
                # Success
                "Server listening on .* port {}.".format(port),
                # Failure
                "Cannot bind any address."])
            if ret == 0:
                self.port = port
                return
        raise SystemError("Could not find a free port to run sshd")

    def stop(self):
        if self.daemon is None:
            return
        self.daemon.terminate(force=True)


def generate_keys_server(builddir, logfile):
    """Generate keys required to run an OpenSSH Daemon."""
    keyfile = os.path.join(builddir, SSHD_KEY)
    if os.path.exists(keyfile):
        logfile.write("> SSH server key already exists '{}'".format(keyfile))
        return

    hostdir = os.path.join(builddir, SSHD_HOST_DIR)
    keydir = os.path.join(builddir, SSHD_KEY_DIR)
    os.makedirs(hostdir, exist_ok=True)
    os.makedirs(keydir, exist_ok=True)

    cmd = ["ssh-keygen", "-A", "-f", hostdir]
    logfile.write(
        "> generating SSH server keys with '{}'\n".format(" ".join(cmd)))
    # When ssh-keygen fails to create an SSH server key it doesn't return a
    # useful error code. So use check for an error message in the output
    # instead.
    try:
        out = subprocess.check_output(cmd, encoding='utf-8')
    except FileNotFoundError:
        logfile.write("> ssh-keygen not found - skipping\n")
        raise SkipTest("ssh-keygen not found")

    logfile.write(out)
    if "Could not save your public key" in out:
        raise SystemError("Could not generate SSH server keys")


def generate_keys_client(builddir, logfile):
    """Generate keys required to log into an OpenSSH Daemon via SCP or SFTP."""
    keyfile = os.path.join(builddir, SSH_CLIENT_KEY)
    if os.path.exists(keyfile):
        logfile.write("> SSH client key already exists '{}'".format(keyfile))
        return

    keydir = os.path.join(builddir, SSH_CLIENT_KEY_DIR)
    os.makedirs(keydir, exist_ok=True)

    cmd = ["ssh-keygen",
           "-f", keyfile,
           "-b", "2048",
           "-t", "rsa",
           "-N", "",
           "-q"]
    logfile.write(
        "> generating SSH client keys with '{}'\n".format(" ".join(cmd)))
    try:
        subprocess.check_call(cmd, stdout=logfile, stderr=logfile)
    except FileNotFoundError:
        logfile.write("> ssh-keygen not found - skipping\n")
        raise SkipTest("ssh-keygen not found")

    # Allow key-based login for this user (so that we can fetch from localhost)
    pubkeyfile = os.path.join(keydir, "{}.pub".format(keyfile))
    authfile = os.path.join(keydir, "authorized_keys")
    shutil.copy(pubkeyfile, authfile)


def generate_keys(builddir, logtofile):
    logfile = infra.open_log_file(builddir, "ssh-keygen", logtofile)
    generate_keys_server(builddir, logfile)
    generate_keys_client(builddir, logfile)
