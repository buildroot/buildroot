import os
import time

import infra.basetest


class TestBitcoin(infra.basetest.BRTest):
    # infra.basetest.BASIC_TOOLCHAIN_CONFIG cannot be used as it does
    # not include BR2_TOOLCHAIN_SUPPORTS_ALWAYS_LOCKFREE_ATOMIC_INTS
    # needed by bitcoin. This config also uses an ext4 rootfs as
    # bitcoind needs some free disk space to start (so we avoid having
    # a larger initrd in RAM).
    config = \
        """
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.1.81"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_PACKAGE_BITCOIN=y
        BR2_PACKAGE_BITCOIN_WALLET=y
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_ROOTFS_EXT2_4=y
        BR2_TARGET_ROOTFS_EXT2_SIZE="256M"
        # BR2_TARGET_ROOTFS_TAR is not set
        """
    # Command prefix for the bitcoin command line interface.
    cli_cmd = "bitcoin-cli -regtest"

    def create_btc_wallet(self, wallet_name):
        """Create an empty wallet."""
        cmd = f"{self.cli_cmd} -named createwallet wallet_name={wallet_name}"
        self.assertRunOk(cmd)

    def gen_btc_address(self, wallet_name):
        """Generate an address in a wallet."""
        cmd = f"{self.cli_cmd} -rpcwallet={wallet_name} getnewaddress"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        return out[0]

    def init_wallet(self, wallet_name):
        """Create a wallet and generate an address in it."""
        self.create_btc_wallet(wallet_name)
        return self.gen_btc_address(wallet_name)

    def get_wallet_balance(self, wallet):
        """Return the (confirmed) balance of a wallet."""
        cmd = f"{self.cli_cmd} -rpcwallet={wallet} getbalance"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        return float(out[0])

    def get_wallet_unconfirmed_balance(self, wallet):
        """Return the unconfirmed balance of a wallet."""
        cmd = f"{self.cli_cmd} -rpcwallet={wallet} getunconfirmedbalance"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        return float(out[0])

    def get_block_count(self):
        """Returns the height of the most-work fully-validated chain."""
        cmd = f"{self.cli_cmd} getblockcount"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        return int(out[0])

    def test_run(self):
        drive = os.path.join(self.builddir, "images", "rootfs.ext4")
        kern = os.path.join(self.builddir, "images", "Image")
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           kernel_cmdline=["root=/dev/vda console=ttyAMA0"],
                           options=["-M", "virt",
                                    "-cpu", "cortex-a53",
                                    "-m", "256M",
                                    "-drive", f"file={drive},if=virtio,format=raw"])
        self.emulator.login()

        # Values for the test.
        wallet1 = "AliceWallet"
        wallet2 = "BobWallet"
        btc_test_amount = 10
        btc_fee = 0.00001
        req_blk_count = 101

        # Check the binary can execute.
        self.assertRunOk("bitcoind --version")

        # This cleanup is useful when run-test -k is used. It makes
        # this test idempotent. Since the drive storage is preserved
        # between reboots, this cleanup will make sure the test always
        # starts from a clean state.
        cmd = "rm -rf ~/.bitcoin"
        self.assertRunOk(cmd)

        # The bitcoin daemon is not started. A client ping is expected
        # to fail.
        ping_cmd = f"{self.cli_cmd} ping"
        _, ret = self.emulator.run(ping_cmd)
        self.assertNotEqual(ret, 0)

        # Start the daemon.
        cmd = f"bitcoind -regtest -daemonwait -fallbackfee={btc_fee:f}"
        self.assertRunOk(cmd)

        time.sleep(2 * self.timeout_multiplier)

        # Now the daemon is started, the ping is expected to succeed.
        self.assertRunOk(ping_cmd)

        # We create two wallets and addresses.
        btc_addr1 = self.init_wallet(wallet1)
        btc_addr2 = self.init_wallet(wallet2)

        # Since the regression test block chain is at its genesis
        # block, we expect a height of zero.
        cur_blk_cnt = self.get_block_count()
        self.assertEqual(cur_blk_cnt, 0)

        # We also expect our wallets to be empty.
        for wallet in [wallet1, wallet2]:
            balance = self.get_wallet_balance(wallet)
            self.assertAlmostEqual(balance, 0.0)

        # We request the generation of several blocks for address
        # #1. We should receive the 50 BTC reward at this address.
        cmd = self.cli_cmd
        cmd += f" generatetoaddress {req_blk_count} {btc_addr1}"
        self.assertRunOk(cmd, timeout=30)

        # We should now see the previously created blocks.
        cur_blk_cnt = self.get_block_count()
        self.assertEqual(cur_blk_cnt, req_blk_count)

        # We should also see the 50 BTC reward in the wallet #1.
        balance = self.get_wallet_balance(wallet1)
        self.assertAlmostEqual(balance, 50.0)

        # The wallet #2 should still be empty.
        balance = self.get_wallet_balance(wallet2)
        self.assertAlmostEqual(balance, 0.0)

        # We send an amount from wallet #1 to #2.
        cmd = f"{self.cli_cmd} -rpcwallet={wallet1}"
        cmd += f" sendtoaddress {btc_addr2} {btc_test_amount}"
        self.assertRunOk(cmd)

        # The wallet #1 balance is expected to be subtracted by the
        # spent amount and the transaction fees.
        expected_balance = 50 - btc_test_amount - btc_fee
        balance = self.get_wallet_balance(wallet1)
        self.assertAlmostEqual(balance, expected_balance, places=4)

        # The transaction is sent, but not confirmed yet. So we should
        # still see a (confirmed) balance of zero.
        balance = self.get_wallet_balance(wallet2)
        self.assertAlmostEqual(balance, 0.0)

        # We should see the transferred amount in the unconfirmed
        # balance.
        balance = self.get_wallet_unconfirmed_balance(wallet2)
        self.assertAlmostEqual(balance, btc_test_amount)

        # We generate 1 block to address #2. This action will confirm
        # the previous transaction (but this will not give the 50 BTC
        # reward).
        cmd = f"{self.cli_cmd} generatetoaddress 1 {btc_addr2}"
        self.assertRunOk(cmd, timeout=30)

        # We should see one more block.
        cur_blk_cnt = self.get_block_count()
        self.assertEqual(cur_blk_cnt, req_blk_count + 1)

        # We should now see the amount in the confirmed balance.
        balance = self.get_wallet_balance(wallet2)
        self.assertAlmostEqual(balance, btc_test_amount)

        # The unconfirmed balance should now be zero.
        balance = self.get_wallet_unconfirmed_balance(wallet2)
        self.assertAlmostEqual(balance, 0.0)
