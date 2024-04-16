"""Test cases for utils/get-developers.

It does not inherit from infra.basetest.BRTest and therefore does not generate
a logfile. Only when the tests fail there will be output to the console.

The file syntax is already tested by the GitLab-CI job check-DEVELOPERS.
"""
import os
import subprocess
import tempfile
import unittest

import infra


def call_script(args, env, cwd):
    """Call a script and return stdout and stderr as lists and the exit code."""
    proc = subprocess.Popen(args, cwd=cwd, stdout=subprocess.PIPE,
                            stderr=subprocess.PIPE, env=env,
                            universal_newlines=True)
    out, err = proc.communicate()
    return out.splitlines(), err.splitlines(), proc.returncode


def call_get_developers(cmd, args, env, cwd, developers_content):
    """Call get-developers overrinding the default DEVELOPERS file."""
    with tempfile.NamedTemporaryFile(buffering=0) as developers_file:
        developers_file.write(developers_content)
        return call_script([cmd, "-d", developers_file.name] + args, env, cwd)


class TestGetDevelopers(unittest.TestCase):
    """Test the various ways the script can be called in a simple top to bottom sequence."""

    WITH_EMPTY_PATH = {}
    WITH_UTILS_IN_PATH = {"PATH": infra.basepath("utils") + ":" + os.environ["PATH"]}

    def test_run(self):
        topdir = infra.basepath()

        # no args, with syntax error in the file
        developers = b'text3\n'
        out, err, rc = call_get_developers("./utils/get-developers", [], self.WITH_EMPTY_PATH, topdir, developers)
        self.assertIn("No action specified", out)
        self.assertEqual(rc, 0)
        self.assertEqual(len(err), 0)

        # -v generating error, called from the main dir
        developers = b'text1\n'
        out, err, rc = call_get_developers("./utils/get-developers", ["-v"], self.WITH_EMPTY_PATH, topdir, developers)
        self.assertIn("Syntax error in DEVELOPERS file, line 1: 'text1'", err)
        self.assertEqual(rc, 1)
        self.assertEqual(len(out), 0)
        self.assertEqual(len(err), 1)

        # -v generating error, called from path
        developers = b'text2\n'
        out, err, rc = call_get_developers("get-developers", ["-v"], self.WITH_UTILS_IN_PATH, topdir, developers)
        self.assertIn("Syntax error in DEVELOPERS file, line 1: 'text2'", err)
        self.assertEqual(rc, 1)
        self.assertEqual(len(out), 0)
        self.assertEqual(len(err), 1)

        # -v generating error for file entry with no developer entry
        developers = b'# comment\n' \
                     b'\n' \
                     b'F:\tutils/get-developers\n' \
                     b'\n' \
                     b'N:\tAuthor2 <email>\n' \
                     b'F:\tutils/get-developers\n'
        out, err, rc = call_get_developers("get-developers", ["-v"], self.WITH_UTILS_IN_PATH, topdir, developers)
        self.assertIn("Syntax error in DEVELOPERS file, line 4", err)
        self.assertEqual(rc, 1)
        self.assertEqual(len(out), 0)
        self.assertEqual(len(err), 1)

        # -v generating error for developer entry with no file entries, stopping on first error
        developers = b'# comment\n' \
                     b'# comment\n' \
                     b'\n' \
                     b'N:\tAuthor1 <email>\n' \
                     b'N:\tAuthor2 <email>\n' \
                     b'N:\tAuthor3 <email>\n' \
                     b'F:\tutils/get-developers\n'
        out, err, rc = call_get_developers("get-developers", ["-v"], self.WITH_UTILS_IN_PATH, topdir, developers)
        self.assertIn("Syntax error in DEVELOPERS file, line 4", err)
        self.assertEqual(rc, 1)
        self.assertEqual(len(out), 0)
        self.assertEqual(len(err), 1)

        # -v not generating error for developer entry with empty list of file entries
        developers = b'# comment\n' \
                     b'# comment\n' \
                     b'\n' \
                     b'N:\tAuthor1 <email>\n' \
                     b'\n' \
                     b'N:\tAuthor2 <email>\n' \
                     b'\n' \
                     b'N:\tAuthor3 <email>\n' \
                     b'F:\tutils/get-developers\n'
        out, err, rc = call_get_developers("get-developers", ["-v"], self.WITH_UTILS_IN_PATH, topdir, developers)
        self.assertEqual(rc, 0)
        self.assertEqual(len(out), 0)
        self.assertEqual(len(err), 0)

        # -v generating warning for old file entry
        developers = b'N:\tAuthor <email>\n' \
                     b'F:\tpath/that/does/not/exists/1\n' \
                     b'F:\tpath/that/does/not/exists/2\n'
        out, err, rc = call_get_developers("get-developers", ["-v"], self.WITH_UTILS_IN_PATH, topdir, developers)
        self.assertIn("WARNING: 'path/that/does/not/exists/1' doesn't match any file, line 2", err)
        self.assertIn("WARNING: 'path/that/does/not/exists/2' doesn't match any file, line 3", err)
        self.assertEqual(rc, 0)
        self.assertEqual(len(out), 0)
        self.assertEqual(len(err), 2)

        # -c generating warning and printing lots of files with no developer
        developers = b'N:\tAuthor <email>\n' \
                     b'F:\tpath/that/does/not/exists/1\n' \
                     b'F:\tpath/that/does/not/exists/2\n'
        out, err, rc = call_get_developers("./utils/get-developers", ["-c"], self.WITH_EMPTY_PATH, topdir, developers)
        self.assertIn("WARNING: 'path/that/does/not/exists/1' doesn't match any file, line 2", err)
        self.assertIn("WARNING: 'path/that/does/not/exists/2' doesn't match any file, line 3", err)
        self.assertEqual(rc, 0)
        self.assertGreater(len(out), 1000)
        self.assertEqual(len(err), 2)

        # -c printing lots of files with no developer
        developers = b'# comment\n' \
                     b'\n' \
                     b'N:\tAuthor <email>\n' \
                     b'F:\tutils/get-developers\n'
        out, err, rc = call_get_developers("./utils/get-developers", ["-c"], self.WITH_EMPTY_PATH, topdir, developers)
        self.assertEqual(rc, 0)
        self.assertGreater(len(out), 1000)
        self.assertEqual(len(err), 0)

        # -p lists more than one developer
        developers = b'N:\tdev1\n' \
                     b'F:\ttoolchain/\n' \
                     b'\n' \
                     b'N:\tdev2\n' \
                     b'F:\ttoolchain/\n'
        out, err, rc = call_get_developers("./utils/get-developers", ["-p", "toolchain"], self.WITH_EMPTY_PATH, topdir, developers)
        self.assertIn("dev1", out)
        self.assertIn("dev2", out)
        self.assertEqual(rc, 0)
        self.assertEqual(len(err), 0)

        # no args, with syntax error in the file
        developers = b'text3\n'
        out, err, rc = call_get_developers("./utils/get-developers", [], self.WITH_EMPTY_PATH, topdir, developers)
        self.assertIn("No action specified", out)
        self.assertEqual(rc, 0)
        self.assertEqual(len(err), 0)

        # patchfile from topdir and from elsewhere
        abs_path = infra.filepath("tests/utils/test_get_developers/")
        rel_file = "0001-package-binutils-change-.mk.patch"
        abs_file = os.path.join(abs_path, rel_file)
        developers = b'N:\tdev1\n' \
                     b'F:\tpackage/binutils/\n'
        out, err, rc = call_get_developers("./utils/get-developers", [abs_file], self.WITH_EMPTY_PATH, topdir, developers)
        self.assertIn('git send-email --to buildroot@buildroot.org --cc "dev1"', out)
        self.assertEqual(rc, 0)
        self.assertEqual(len(err), 0)
        out, err, rc = call_get_developers("get-developers", [rel_file], self.WITH_UTILS_IN_PATH, abs_path, developers)
        self.assertIn('git send-email --to buildroot@buildroot.org --cc "dev1"', out)
        self.assertEqual(rc, 0)
        self.assertEqual(len(err), 0)
