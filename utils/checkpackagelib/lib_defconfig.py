# See utils/checkpackagelib/readme.txt before editing this file.

from checkpackagelib.base import _CheckFunction


class ForceCheckHash(_CheckFunction):
    """Checks that a defconfig does force checking all hashes"""

    def before(self):
        self.forces = False

    def check_line(self, lineno, text):
        if self.forces:
            return
        if text == "BR2_DOWNLOAD_FORCE_CHECK_HASHES=y\n":
            self.forces = True

    def after(self):
        if not self.forces:
            return [f"{self.filename}:0: missing BR2_DOWNLOAD_FORCE_CHECK_HASHES"]
