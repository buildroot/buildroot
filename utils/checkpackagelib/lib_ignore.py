# See utils/checkpackagelib/readme.txt before editing this file.

import os

from checkpackagelib.base import _CheckFunction


class IgnoreMissingFile(_CheckFunction):
    def check_line(self, lineno, text):
        fields = text.split()
        if not os.path.exists(fields[0]):
            return ["{}:{}: ignored file {} is missing"
                    .format(self.filename, lineno, fields[0]),
                    text]
