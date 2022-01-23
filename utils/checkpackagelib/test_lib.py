import pytest
import checkpackagelib.test_util as util
import checkpackagelib.lib as m


ConsecutiveEmptyLines = [
    ('1 line (no newline)',
     'any',
     '',
     []),
    ('1 line',
     'any',
     '\n',
     []),
    ('2 lines',
     'any',
     '\n'
     '\n',
     [['any:2: consecutive empty lines']]),
    ('more than 2 consecutive',
     'any',
     '\n'
     '\n'
     '\n',
     [['any:2: consecutive empty lines'],
      ['any:3: consecutive empty lines']]),
    ('ignore whitespace 1',
     'any',
     '\n'
     ' ',
     [['any:2: consecutive empty lines']]),
    ('ignore whitespace 2',
     'any',
     ' \n'
     '\t\n',
     [['any:2: consecutive empty lines']]),
    ]


@pytest.mark.parametrize('testname,filename,string,expected', ConsecutiveEmptyLines)
def test_ConsecutiveEmptyLines(testname, filename, string, expected):
    warnings = util.check_file(m.ConsecutiveEmptyLines, filename, string)
    assert warnings == expected


EmptyLastLine = [
    ('ignore empty file',
     'any',
     '',
     []),
    ('empty line (newline)',
     'any',
     '\n',
     [['any:1: empty line at end of file']]),
    ('empty line (space, newline)',
     'any',
     ' \n',
     [['any:1: empty line at end of file']]),
    ('empty line (space, no newline)',
     'any',
     ' ',
     [['any:1: empty line at end of file']]),
    ('warn for the last of 2',
     'any',
     '\n'
     '\n',
     [['any:2: empty line at end of file']]),
    ('warn for the last of 3',
     'any',
     '\n'
     '\n'
     '\n',
     [['any:3: empty line at end of file']]),
    ('ignore whitespace',
     'any',
     ' \n'
     '\t\n',
     [['any:2: empty line at end of file']]),
    ]


@pytest.mark.parametrize('testname,filename,string,expected', EmptyLastLine)
def test_EmptyLastLine(testname, filename, string, expected):
    warnings = util.check_file(m.EmptyLastLine, filename, string)
    assert warnings == expected


NewlineAtEof = [
    ('good',
     'any',
     'text\n',
     []),
    ('text (bad)',
     'any',
     '\n'
     'text',
     [['any:2: missing newline at end of file',
       'text']]),
    ('space (bad)',
     'any',
     '\n'
     ' ',
     [['any:2: missing newline at end of file',
       ' ']]),
    ('tab (bad)',
     'any',
     '\n'
     '\t',
     [['any:2: missing newline at end of file',
       '\t']]),
    ('even for file with one line',
     'any',
     ' ',
     [['any:1: missing newline at end of file',
       ' ']]),
    ]


@pytest.mark.parametrize('testname,filename,string,expected', NewlineAtEof)
def test_NewlineAtEof(testname, filename, string, expected):
    warnings = util.check_file(m.NewlineAtEof, filename, string)
    assert warnings == expected


TrailingSpace = [
    ('good',
     'any',
     'text\n',
     []),
    ('ignore missing newline',
     'any',
     '\n'
     'text',
     []),
    ('spaces',
     'any',
     'text  \n',
     [['any:1: line contains trailing whitespace',
       'text  \n']]),
    ('tabs after text',
     'any',
     'text\t\t\n',
     [['any:1: line contains trailing whitespace',
       'text\t\t\n']]),
    ('mix of tabs and spaces',
     'any',
     ' \n'
     ' ',
     [['any:1: line contains trailing whitespace',
       ' \n'],
      ['any:2: line contains trailing whitespace',
       ' ']]),
    ('blank line with tabs',
     'any',
     '\n'
     '\t',
     [['any:2: line contains trailing whitespace',
       '\t']]),
    ]


@pytest.mark.parametrize('testname,filename,string,expected', TrailingSpace)
def test_TrailingSpace(testname, filename, string, expected):
    warnings = util.check_file(m.TrailingSpace, filename, string)
    assert warnings == expected


Utf8Characters = [
    ('usual',
     'any',
     'text\n',
     []),
    ('acceptable character',
     'any',
     '\x60',
     []),
    ('unacceptable character',
     'any',
     '\x81',
     [['any:1: line contains UTF-8 characters',
       '\x81']]),
    ('2 warnings',
     'any',
     'text\n'
     'text \xc8 text\n'
     '\xc9\n',
     [['any:2: line contains UTF-8 characters',
       'text \xc8 text\n'],
      ['any:3: line contains UTF-8 characters',
       '\xc9\n']]),
    ]


@pytest.mark.parametrize('testname,filename,string,expected', Utf8Characters)
def test_Utf8Characters(testname, filename, string, expected):
    warnings = util.check_file(m.Utf8Characters, filename, string)
    assert warnings == expected


def test_all_check_functions_are_used():
    import inspect
    import checkpackagelib.lib_config as lib_config
    import checkpackagelib.lib_hash as lib_hash
    import checkpackagelib.lib_mk as lib_mk
    import checkpackagelib.lib_patch as lib_patch
    c_config = [c[0] for c in inspect.getmembers(lib_config, inspect.isclass)]
    c_hash = [c[0] for c in inspect.getmembers(lib_hash, inspect.isclass)]
    c_mk = [c[0] for c in inspect.getmembers(lib_mk, inspect.isclass)]
    c_patch = [c[0] for c in inspect.getmembers(lib_patch, inspect.isclass)]
    c_all = c_config + c_hash + c_mk + c_patch
    c_common = [c[0] for c in inspect.getmembers(m, inspect.isclass)]
    assert set(c_common) <= set(c_all)
