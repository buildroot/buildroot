import os

import infra.basetest


class TestLlamaCpp(infra.basetest.BRTest):
    config = """
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_SYSTEM_DHCP="eth0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.12.55"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_PACKAGE_CA_CERTIFICATES=y
        BR2_PACKAGE_OPENSSL=y
        BR2_PACKAGE_LIBCURL=y
        BR2_PACKAGE_LIBCURL_CURL=y
        BR2_PACKAGE_LLAMA_CPP=y
        BR2_PACKAGE_LLAMA_CPP_TOOLS=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_ROOTFS_EXT2_SIZE="1024M"
        # BR2_TARGET_ROOTFS_TAR is not set
    """

    def login(self):
        img = os.path.join(self.builddir, "images", "rootfs.ext2")
        kern = os.path.join(self.builddir, "images", "Image")
        self.emulator.boot(
            arch="aarch64",
            kernel=kern,
            kernel_cmdline=["root=/dev/vda", "console=ttyAMA0"],
            options=[
                "-M", "virt",
                "-cpu", "cortex-a57",
                "-smp", "4",
                "-m", "2G",
                "-drive", f"file={img},if=virtio,format=raw",
                "-net", "nic,model=virtio",
                "-net", "user"
            ]
        )
        self.emulator.login()

    def test_run(self):
        self.login()

        # Check the program can execute.
        self.assertRunOk("llama-cli --version")

        # We define a Hugging Face model to be downloaded.
        # We choose a relatively small model, for testing.
        hf_model = "ggml-org/gemma-3-270m-it-GGUF"

        # We define a common knowledge question to ask to the model.
        prompt = "What is the capital of the United Kingdom?"

        # We define an expected keyword, to be present in the answer.
        expected_answer = "london"

        # We set few llama-cli options:
        # We don't want an interactive session
        llama_opts = "--single-turn"
        llama_opts += " --no-display-prompt"
        # We set a fixed seed, to reduce variability of the test
        llama_opts += " --seed 123456789"
        llama_opts += f" --hf-repo {hf_model}"
        llama_opts += f" --prompt '{prompt}'"

        # Run the command. We suppress all stderr output logs to get
        # only the answer. Remove the redirection for debugging.
        cmd = f"llama-cli {llama_opts} 2>/dev/null"
        out, ret = self.emulator.run(cmd, timeout=60)
        self.assertEqual(ret, 0)
        out_str = "\n".join(out).lower()
        self.assertIn(expected_answer, out_str)
