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
