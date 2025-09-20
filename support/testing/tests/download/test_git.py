import os
import shutil

import tests.download.gitconfig

import infra


class GitTestBase(infra.basetest.BRConfigTest):
    config = \
        """
        BR2_BACKUP_SITE=""
        """
    gitremotedir = infra.filepath("tests/download/git-remote")

    def setUp(self):
        super(GitTestBase, self).setUp()

        self.show_msg("Generating custom git config")
        tests.download.gitconfig.generate_gitconfig(self.builddir,
                                                    self.logtofile,
                                                    self.gitremotedir)

    def tearDown(self):
        self.show_msg("Cleaning up")
        if self.b and not self.keepbuilds:
            self.b.delete()

    def check_hash(self, package):
        gitconfig = os.path.join(self.builddir,
                                 tests.download.gitconfig.GIT_CONFIG_FILE)
        # store downloaded tarball inside the output dir so the test infra
        # cleans it up at the end
        env = {"BR2_DL_DIR": os.path.join(self.builddir, "dl"),
               "GITREMOTE_DIR": self.gitremotedir,
               "GIT_CONFIG_GLOBAL": gitconfig}
        self.b.build(["{}-dirclean".format(package),
                      "{}-source".format(package)],
                     env)

    def check_download(self, package):
        gitconfig = os.path.join(self.builddir,
                                 tests.download.gitconfig.GIT_CONFIG_FILE)
        # store downloaded tarball inside the output dir so the test infra
        # cleans it up at the end
        dl_dir = os.path.join(self.builddir, "dl")
        # enforce we test the download
        if os.path.exists(dl_dir):
            shutil.rmtree(dl_dir)
        env = {"BR2_DL_DIR": dl_dir,
               "GITREMOTE_DIR": self.gitremotedir,
               "GIT_CONFIG_GLOBAL": gitconfig}
        self.b.build(["{}-dirclean".format(package),
                      "{}-legal-info".format(package)],
                     env)


class TestGitHash(GitTestBase):
    br2_external = [infra.filepath("tests/download/br2-external/git-hash")]

    def test_run(self):
        with self.assertRaises(SystemError):
            self.check_hash("bad")
        self.check_hash("good")
        self.check_hash("nohash")
        self.check_hash("export-subst")
        with open(os.path.join(self.builddir, "dl", "export-subst", "git", "file2"), "r") as f:
            blob = f.read()
        self.assertEqual(blob, "0fdb95cf4f3c5ed4003287649cabb33c5f843e26\n")


class TestGitRefs(GitTestBase):
    br2_external = [infra.filepath("tests/download/br2-external/git-refs")]

    def test_run(self):
        with self.assertRaises(SystemError):
            self.check_download("git-wrong-content")
        with self.assertRaises(SystemError):
            self.check_download("git-wrong-sha1")
        self.check_download("git-partial-sha1-branch-head")
        self.check_download("git-partial-sha1-reachable-by-branch")
        self.check_download("git-partial-sha1-reachable-by-tag")
        self.check_download("git-partial-sha1-tag-itself")
        self.check_download("git-partial-sha1-tag-points-to")
        self.check_download("git-sha1-branch-head")
        self.check_download("git-sha1-reachable-by-branch")
        self.check_download("git-sha1-reachable-by-tag")
        self.check_download("git-sha1-tag-itself")
        self.check_download("git-sha1-tag-points-to")
        self.check_download("git-submodule-disabled")
        self.check_download("git-submodule-enabled")
        self.check_download("git-tag")
