import os
import pytest
import re
import tempfile
import checkpackagelib.tool as m

workdir_regex = re.compile(r'/tmp/tmp[^/]*-checkpackagelib-test-tool')


def check_file(tool, filename, string, permissions=None):
    with tempfile.TemporaryDirectory(suffix='-checkpackagelib-test-tool') as workdir:
        script = os.path.join(workdir, filename)
        with open(script, 'wb') as f:
            f.write(string.encode())
        if permissions:
            os.chmod(script, permissions)
        obj = tool(script)
        result = obj.run()
        if result is None:
            return []
        return [workdir_regex.sub('dir', r) for r in result]


NotExecutable = [
    ('664',
     'package.mk',
     0o664,
     '',
     []),
    ('775',
     'package.mk',
     0o775,
     '',
     ["dir/package.mk:0: This file does not need to be executable"]),
    ]


@pytest.mark.parametrize('testname,filename,permissions,string,expected', NotExecutable)
def test_NotExecutable(testname, filename, permissions, string, expected):
    warnings = check_file(m.NotExecutable, filename, string, permissions)
    assert warnings == expected


NotExecutable_hint = [
    ('no hint',
     "",
     'sh-shebang.sh',
     0o775,
     '#!/bin/sh',
     ["dir/sh-shebang.sh:0: This file does not need to be executable"]),
    ('hint',
     ", very special hint",
     'sh-shebang.sh',
     0o775,
     '#!/bin/sh',
     ["dir/sh-shebang.sh:0: This file does not need to be executable, very special hint"]),
    ]


@pytest.mark.parametrize('testname,hint,filename,permissions,string,expected', NotExecutable_hint)
def test_NotExecutable_hint(testname, hint, filename, permissions, string, expected):
    class NotExecutable(m.NotExecutable):
        def hint(self):
            return hint
    warnings = check_file(NotExecutable, filename, string, permissions)
    assert warnings == expected


Shellcheck = [
    ('missing shebang',
     'empty.sh',
     '',
     ["dir/empty.sh:0: run 'shellcheck' and fix the warnings",
      "In dir/empty.sh line 1:\n"
      "^-- SC2148: Tips depend on target shell and yours is unknown. Add a shebang or a 'shell' directive.\n"
      "For more information:\n"
      "  https://www.shellcheck.net/wiki/SC2148 -- Tips depend on target shell and y..."]),
    ('sh shebang',
     'sh-shebang.sh',
     '#!/bin/sh',
     []),
    ('bash shebang',
     'bash-shebang.sh',
     '#!/bin/bash',
     []),
    ('2 warnings',
     'unused.sh',
     'unused=""',
     ["dir/unused.sh:0: run 'shellcheck' and fix the warnings",
      "In dir/unused.sh line 1:\n"
      'unused=""\n'
      "^-- SC2148: Tips depend on target shell and yours is unknown. Add a shebang or a 'shell' directive.\n"
      "^----^ SC2034: unused appears unused. Verify use (or export if used externally).\n"
      "For more information:\n"
      "  https://www.shellcheck.net/wiki/SC2148 -- Tips depend on target shell and y...\n"
      "  https://www.shellcheck.net/wiki/SC2034 -- unused appears unused. Verify use..."]),
    ('tab',
     'tab.sh',
     '\t#!/bin/sh',
     ["dir/tab.sh:0: run 'shellcheck' and fix the warnings",
      "In dir/tab.sh line 1:\n"
      '\t#!/bin/sh\n'
      "^-- SC1114: Remove leading spaces before the shebang.\n"
      "For more information:\n"
      "  https://www.shellcheck.net/wiki/SC1114 -- Remove leading spaces before the ..."]),
    ]


@pytest.mark.parametrize('testname,filename,string,expected', Shellcheck)
def test_Shellcheck(testname, filename, string, expected):
    warnings = check_file(m.Shellcheck, filename, string)
    assert warnings == expected
