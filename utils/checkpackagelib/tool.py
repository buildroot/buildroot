import os
from checkpackagelib.base import _Tool


class NotExecutable(_Tool):
    def run(self):
        if os.access(self.filename, os.X_OK):
            return ["{}:0: This file does not need to be executable".format(self.filename)]
