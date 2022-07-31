import flake8.main.application
import os
import subprocess
import tempfile
from checkpackagelib.base import _Tool


class NotExecutable(_Tool):
    def ignore(self):
        return False

    def run(self):
        if self.ignore():
            return
        if os.access(self.filename, os.X_OK):
            return ["{}:0: This file does not need to be executable{}".format(self.filename, self.hint())]


class Flake8(_Tool):
    def run(self):
        with tempfile.NamedTemporaryFile() as output:
            app = flake8.main.application.Application()
            app.run(['--output-file={}'.format(output.name), self.filename])
            stdout = output.readlines()
            processed_output = [str(line.decode().rstrip()) for line in stdout if line]
            if len(stdout) == 0:
                return
            return ["{}:0: run 'flake8' and fix the warnings".format(self.filename),
                    '\n'.join(processed_output)]


class Shellcheck(_Tool):
    def run(self):
        cmd = ['shellcheck', self.filename]
        try:
            p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            stdout = p.communicate()[0]
            processed_output = [str(line.decode().rstrip()) for line in stdout.splitlines() if line]
            if p.returncode == 0:
                return
            return ["{}:0: run 'shellcheck' and fix the warnings".format(self.filename),
                    '\n'.join(processed_output)]
        except FileNotFoundError:
            return ["{}:0: failed to call 'shellcheck'".format(self.filename)]
