import os
import pytest
import re
import tempfile
import checkpackagelib.test_util as util
import checkpackagelib.lib_sysv as m
from checkpackagelib.test_tool import check_file as tool_check_file

workdir = os.path.join(tempfile.mkdtemp(suffix='-checkpackagelib-test-sysv'))
workdir_regex = re.compile(r'/tmp/tmp[^/]*-checkpackagelib-test-sysv')


Indent = [
    ('empty file',
     'any',
     '',
     []),
    ('empty line',
     'any',
     '\n',
     []),
    ('ignore whitespace',
     'any',
     ' \n',
     []),
    ('spaces',
     'any',
     'case "$1" in\n'
     '  start)',
     [['any:2: should be indented with tabs (url#adding-packages-start-script)',
       '  start)']]),
    ('tab',
     'any',
     'case "$1" in\n'
     '\tstart)',
     []),
    ('tabs and spaces',
     'any',
     'case "$1" in\n'
     '\t  start)',
     [['any:2: should be indented with tabs (url#adding-packages-start-script)',
       '\t  start)']]),
    ('spaces and tabs',
     'any',
     'case "$1" in\n'
     '  \tstart)',
     [['any:2: should be indented with tabs (url#adding-packages-start-script)',
       '  \tstart)']]),
    ]


@pytest.mark.parametrize('testname,filename,string,expected', Indent)
def test_Indent(testname, filename, string, expected):
    warnings = util.check_file(m.Indent, filename, string)
    assert warnings == expected


NotExecutable = [
    ('SysV',
     'sh-shebang.sh',
     0o775,
     '#!/bin/sh',
     ["dir/sh-shebang.sh:0: This file does not need to be executable,"
      " just make sure you use '$(INSTALL) -D -m 0755' in the .mk file"]),
    ]


@pytest.mark.parametrize('testname,filename,permissions,string,expected', NotExecutable)
def test_NotExecutable(testname, filename, permissions, string, expected):
    warnings = tool_check_file(m.NotExecutable, filename, string, permissions)
    assert warnings == expected


Variables = [
    ('empty file',
     'any',
     '',
     [['any:0: DAEMON variable not defined (url#adding-packages-start-script)']]),
    ('daemon and pidfile ok',
     'package/busybox/S01syslogd',
     'DAEMON="syslogd"\n'
     'PIDFILE="/var/run/$DAEMON.pid"\n',
     []),
    ('wrong filename',
     'package/busybox/S01syslog',
     'DAEMON="syslogd"\n'
     'PIDFILE="/var/run/${DAEMON}.pid"\n',
     [['package/busybox/S01syslog:0: filename should be S<number><number><daemon name> (url#adding-packages-start-script)',
       'expecting S<number><number>syslogd']]),
    ('no pidfile ok',
     'S99something',
     'DAEMON="something"\n',
     []),
    ('hardcoded pidfile',
     'S99something',
     'DAEMON="something"\n'
     'PIDFILE="/var/run/something.pid"\n',
     [['S99something:2: Incorrect PIDFILE value  (url#adding-packages-start-script)',
       'PIDFILE="/var/run/something.pid"\n',
       'PIDFILE="/var/run/$DAEMON.pid"']]),
    ('redefined daemon',
     'S50any',
     'DAEMON="any"\n'
     'DAEMON="other"\n',
     [['S50any:2: DAEMON variable redefined (url#adding-packages-start-script)',
       'DAEMON="other"\n']]),
    ('daemon name with dash',
     'S82cups-browsed',
     'DAEMON="cups-browsed"',
     []),
    ('daemon with path',
     'S50avahi-daemon',
     'DAEMON=/usr/sbin/avahi-daemon',
     [['S50avahi-daemon:1: Do not include path in DAEMON (url#adding-packages-start-script)',
       'DAEMON=/usr/sbin/avahi-daemon',
       'DAEMON="avahi-daemon"']]),
    ('daemon with path and wrong filename',
     'S50avahi',
     'DAEMON=/usr/sbin/avahi-daemon',
     [['S50avahi:1: Do not include path in DAEMON (url#adding-packages-start-script)',
       'DAEMON=/usr/sbin/avahi-daemon',
       'DAEMON="avahi-daemon"'],
      ['S50avahi:0: filename should be S<number><number><daemon name> (url#adding-packages-start-script)',
       'expecting S<number><number>avahi-daemon']]),
    ]


@pytest.mark.parametrize('testname,filename,string,expected', Variables)
def test_Variables(testname, filename, string, expected):
    warnings = util.check_file(m.Variables, filename, string)
    assert warnings == expected
