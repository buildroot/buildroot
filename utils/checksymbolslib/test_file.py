import os
import pytest
import tempfile
import checksymbolslib.file as m


def test_get_list_of_files_in_the_repo():
    all_files = m.get_list_of_files_in_the_repo()
    assert 'Makefile' in all_files
    assert 'package/Config.in' in all_files
    assert len(all_files) > 1000


get_list_of_files_to_process = [
    ('unknown file type',
     ['a/file/Config.in',
      'another/file.mk',
      'unknown/file/type'],
     ['a/file/Config.in',
      'another/file.mk']),
    ('runtime test infra fixtures',
     ['a/file/Config.in',
      'support/testing/a/broken/Config.in',
      'another/file.mk'],
     ['a/file/Config.in',
      'another/file.mk']),
    ]


@pytest.mark.parametrize('testname,all_files,expected', get_list_of_files_to_process)
def test_get_list_of_files_to_process(testname, all_files, expected):
    files_to_process = m.get_list_of_files_to_process(all_files)
    assert files_to_process == expected


get_list_of_filenames_with_pattern = [
    ('ignored directories',
     ['a/file/Config.in',
      'support/testing/a/broken/file/Config.in',
      'not/found.mk',
      'another/file.mk'],
     ['a/file/Config.in',
      'not/found.mk',
      'another/file.mk'],
     'file',
     ['support/testing/a/broken/file/Config.in']),
    ('processed files',
     ['a/file/Config.in',
      'not/found.mk',
      'another/file.mk'],
     [],
     'file',
     ['a/file/Config.in',
      'another/file.mk']),
    ('case sensitive',
     ['a/file/Config.in',
      'not/found.mk',
      'another/file.mk'],
     [],
     'FILE',
     []),
    ('or',
     ['a/file/Config.in',
      'not/found.mk',
      'another/file.mk'],
     [],
     'file|FILE',
     ['a/file/Config.in',
      'another/file.mk']),
    ('complex regexp',
     ['a/file/Config.in',
      'not/found.mk',
      'another/file.mk'],
     [],
     '^n[oO]+t.*mk$',
     ['not/found.mk']),
    ]


@pytest.mark.parametrize('testname,all_files,files_to_process,pattern,expected', get_list_of_filenames_with_pattern)
def test_get_list_of_filenames_with_pattern(testname, all_files, files_to_process, pattern, expected):
    files_to_process = m.get_list_of_filenames_with_pattern(all_files, files_to_process, pattern)
    assert files_to_process == expected


read_file = [
    ('indent',
     'file1',
     ' content1\n'
     '\t# comment1',
     [[1, ' content1\n'],
      [2, '\t# comment1']]),
    ('trailing space',
     'file2',
     'content2 \n'
     '# comment2\t\n',
     [[1, 'content2 \n'],
      [2, '# comment2\t\n']]),
    ('empty line',
     'file3',
     '\n'
     '\n',
     [[1, '\n'],
      [2, '\n']]),
    ('missing newline at EOF',
     'file4',
     '\n'
     ' text\t',
     [[1, '\n'],
      [2, ' text\t']]),
    ]


@pytest.mark.parametrize('testname,filename,content,,expected', read_file)
def test_read_file(testname, filename, content, expected):
    with tempfile.TemporaryDirectory(suffix='-checksymbolslib-test-file') as workdir:
        full_filename = os.path.join(workdir, filename)
        with open(full_filename, 'wb') as f:
            f.write(content.encode())
        read_file_content = m.read_file(full_filename)
    assert read_file_content == expected


cleanup_file_content = [
    ('empty file',
     [],
     []),
    ('empty line',
     [[5, '\n']],
     [[5, '']]),
    ('trailing space',
     [[3, '    \n']],
     [[3, '    ']]),
    ('trailing tab',
     [[3, '\t\n']],
     [[3, '\t']]),
    ('1 continuation',
     [[1, 'foo \\\n'],
      [2, 'bar\n']],
     [[1, 'foo bar']]),
    ('2 continuations',
     [[1, 'foo \\\n'],
      [2, 'bar  \\\n'],
      [3, 'baz\n']],
     [[1, 'foo bar  baz']]),
    ]


@pytest.mark.parametrize('testname,file_content_raw,expected', cleanup_file_content)
def test_cleanup_file_content(testname, file_content_raw, expected):
    cleaned_up_content = m.cleanup_file_content(file_content_raw)
    assert cleaned_up_content == expected
