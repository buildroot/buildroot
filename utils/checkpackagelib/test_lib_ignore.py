import pytest
import checkpackagelib.test_util as util
import checkpackagelib.lib_ignore as m


IgnoreMissingFile = [
    ('missing ignored file',
     '.checkpackageignore',
     'this-file-does-not-exist SomeTest',
     [['.checkpackageignore:1: ignored file this-file-does-not-exist is missing',
       'this-file-does-not-exist SomeTest']]),
    ]


@pytest.mark.parametrize('testname,filename,string,expected', IgnoreMissingFile)
def test_IgnoreMissingFile(testname, filename, string, expected):
    warnings = util.check_file(m.IgnoreMissingFile, filename, string)
    assert warnings == expected
