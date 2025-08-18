import os
import shutil

import tests.download.sshd

import infra


class SSHTestBase(infra.basetest.BRConfigTest):
    config = infra.basetest.MINIMAL_CONFIG + '''
BR2_BACKUP_SITE=""
'''
    sshd_test_dir = infra.filepath("tests/download/sshd")
    sshd = None

    def setUp(self):
        super(SSHTestBase, self).setUp()

        self.show_msg("Generating keys")
        tests.download.sshd.generate_keys(self.builddir, self.logtofile)

        self.show_msg("Starting sshd")
        self.sshd = tests.download.sshd.OpenSSHDaemon(self.builddir,
                                                      self.logtofile)

    def tearDown(self):
        self.show_msg("Stopping sshd")
        if self.sshd:
            self.sshd.stop()
        super(SSHTestBase, self).tearDown()

    def download_package(self, package):
        self.show_msg("Downloading {}".format(package))
        # store downloaded tarball inside the output dir so the test infra
        # cleans it up at the end
        dl_dir = os.path.join(self.builddir, "dl")
        ssh_identity = os.path.join(self.builddir,
                                    tests.download.sshd.SSH_CLIENT_KEY)
        # enforce that we test the download
        if os.path.exists(dl_dir):
            shutil.rmtree(dl_dir)
        env = {"BR2_DL_DIR": dl_dir,
               "SSHD_PORT_NUMBER": str(self.sshd.port),
               "SSHD_TEST_DIR": self.sshd_test_dir,
               "SSH_IDENTITY": ssh_identity}
        self.b.build(["{}-dirclean".format(package),
                      "{}-source".format(package)],
                     env)


class TestSCP(SSHTestBase):
    br2_external = [infra.filepath("tests/download/br2-external/ssh")]

    def test_run(self):
        self.download_package("scp")


class TestSFTP(SSHTestBase):
    br2_external = [infra.filepath("tests/download/br2-external/ssh")]

    def test_run(self):
        self.download_package("sftp")
