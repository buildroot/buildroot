import os
import shutil

import infra


class GitforgeTestBase(infra.basetest.BRConfigTest):
    config = \
        """
        BR2_BACKUP_SITE=""
        """

    def setUp(self):
        super(GitforgeTestBase, self).setUp()

    def tearDown(self):
        self.show_msg("Cleaning up")
        if self.b and not self.keepbuilds:
            self.b.delete()

    def check_download(self, package):
        # store downloaded tarball inside the output dir so the test infra
        # cleans it up at the end
        dl_dir = os.path.join(self.builddir, "dl")
        # enforce we test the download
        if os.path.exists(dl_dir):
            shutil.rmtree(dl_dir)
        env = {"BR2_DL_DIR": dl_dir}
        self.b.build(["{}-dirclean".format(package),
                      "{}-legal-info".format(package)],
                     env)


class TestGitHub(GitforgeTestBase):
    br2_external = [infra.filepath("tests/download/br2-external/github")]

    def test_run(self):
        self.check_download("github-helper-tag")
        self.check_download("github-helper-hash")
        self.check_download("github-release")


class TestGitLab(GitforgeTestBase):
    br2_external = [infra.filepath("tests/download/br2-external/gitlab")]

    def test_run(self):
        self.check_download("gitlab-helper-hash")
        self.check_download("gitlab-helper-tag")
        self.check_download("gitlab-release")
