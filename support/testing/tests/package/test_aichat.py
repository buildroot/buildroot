import json
import os
import time

import infra.basetest


class TestAiChat(infra.basetest.BRTest):
    rootfs_overlay = \
        infra.filepath("tests/package/test_aichat/rootfs-overlay")
    config = f"""
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_SYSTEM_DHCP="eth0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.18.3"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_PACKAGE_AICHAT=y
        BR2_PACKAGE_CA_CERTIFICATES=y
        BR2_PACKAGE_LIBCURL=y
        BR2_PACKAGE_LIBCURL_CURL=y
        BR2_PACKAGE_LLAMA_CPP=y
        BR2_PACKAGE_LLAMA_CPP_SERVER=y
        BR2_PACKAGE_LLAMA_CPP_TOOLS=y
        BR2_PACKAGE_OPENSSL=y
        BR2_ROOTFS_OVERLAY="{rootfs_overlay}"
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
            kernel_cmdline=["root=/dev/vda"],
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
        self.assertRunOk("aichat --version")

        # We define a Hugging Face model to be downloaded.
        # We choose a relatively small model, for testing.
        hf_model = "ggml-org/gemma-3-270m-it-GGUF"

        # We define a common knowledge question to ask to the model.
        prompt = "What is the capital of the United Kingdom?"

        # We define an expected keyword, to be present in the answer.
        expected_answer = "london"

        # We set few llama-server options:
        llama_opts = "--log-file /tmp/llama-server.log"
        # We set a fixed seed, to reduce variability of the test
        llama_opts += " --seed 123456789"
        llama_opts += f" --hf-repo {hf_model}"

        # We start a llama-server in background, which will expose an
        # openai-compatible API to be used by aichat.
        cmd = f"( llama-server {llama_opts} &>/dev/null & )"
        self.assertRunOk(cmd)

        # We wait for the llama-server to be ready. We query the
        # available models API to check the server is ready. We expect
        # to see the our model. We also add an extra "echo" to add an
        # extra newline.
        cmd = "curl http://127.0.0.1:8080/v1/models && echo"
        for attempt in range(20 * self.timeout_multiplier):
            time.sleep(5)
            # To debug the llama-server startup, uncomment the
            # following line:
            # self.assertRunOk("cat /tmp/llama-server.log")
            out, ret = self.emulator.run(cmd)
            if ret == 0:
                models_json = "".join(out)
                models = json.loads(models_json)
                model_name = models['models'][0]['name']
                if model_name == hf_model:
                    break
        else:
            self.fail("Timeout while waiting for llama-server.")

        # We ask our question and check the expected answer is present
        # in the output. We pipe the output in "cat" to suppress the
        # aichat UTF-8 spinner (aichat stdout will not be a tty).
        cmd = f"aichat '{prompt}' | cat"
        out, ret = self.emulator.run(cmd, timeout=120)
        self.assertEqual(ret, 0)
        out_str = "\n".join(out).lower()
        self.assertIn(expected_answer, out_str)
