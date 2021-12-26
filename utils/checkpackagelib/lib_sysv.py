import os
import re

from checkpackagelib.base import _CheckFunction
from checkpackagelib.lib import ConsecutiveEmptyLines  # noqa: F401
from checkpackagelib.lib import EmptyLastLine          # noqa: F401
from checkpackagelib.lib import NewlineAtEof           # noqa: F401
from checkpackagelib.lib import TrailingSpace          # noqa: F401
import checkpackagelib.tool
from checkpackagelib.tool import Shellcheck            # noqa: F401


class Indent(_CheckFunction):
    INDENTED_WITH_SPACES = re.compile(r"^[\t]* ")

    def check_line(self, lineno, text):
        if self.INDENTED_WITH_SPACES.search(text.rstrip()):
            return ["{}:{}: should be indented with tabs ({}#adding-packages-start-script)"
                    .format(self.filename, lineno, self.url_to_manual),
                    text]


class NotExecutable(checkpackagelib.tool.NotExecutable):
    def hint(self):
        return ", just make sure you use '$(INSTALL) -D -m 0755' in the .mk file"


class Variables(_CheckFunction):
    DAEMON_VAR = re.compile(r"^DAEMON=[\"']{0,1}([^\"']*)[\"']{0,1}")
    PIDFILE_PATTERN = re.compile(r"/var/run/(\$DAEMON|\$\{DAEMON\}).pid")
    PIDFILE_VAR = re.compile(r"^PIDFILE=[\"']{0,1}([^\"']*)[\"']{0,1}")

    def before(self):
        self.name = None

    def check_line(self, lineno, text):
        name_found = self.DAEMON_VAR.search(text.rstrip())
        if name_found:
            if self.name:
                return ["{}:{}: DAEMON variable redefined ({}#adding-packages-start-script)"
                        .format(self.filename, lineno, self.url_to_manual),
                        text]
            self.name = name_found.group(1)
            if '/' in self.name:
                self.name = os.path.basename(self.name)  # to be used in after() to check the expected filename
                return ["{}:{}: Do not include path in DAEMON ({}#adding-packages-start-script)"
                        .format(self.filename, lineno, self.url_to_manual),
                        text,
                        'DAEMON="{}"'.format(self.name)]
            return

        pidfile_found = self.PIDFILE_VAR.search(text.rstrip())
        if pidfile_found:
            pidfile = pidfile_found.group(1)
            if not self.PIDFILE_PATTERN.match(pidfile):
                return ["{}:{}: Incorrect PIDFILE value  ({}#adding-packages-start-script)"
                        .format(self.filename, lineno, self.url_to_manual),
                        text,
                        'PIDFILE="/var/run/$DAEMON.pid"']

    def after(self):
        if self.name is None:
            return ["{}:0: DAEMON variable not defined ({}#adding-packages-start-script)"
                    .format(self.filename, self.url_to_manual)]
        expected_filename = re.compile(r"S\d\d{}$".format(self.name))
        if not expected_filename.match(os.path.basename(self.filename)):
            return ["{}:0: filename should be S<number><number><daemon name> ({}#adding-packages-start-script)"
                    .format(self.filename, self.url_to_manual),
                    "expecting S<number><number>{}".format(self.name)]
