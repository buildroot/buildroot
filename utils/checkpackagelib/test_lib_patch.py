import pytest
import checkpackagelib.test_util as util
import checkpackagelib.lib_patch as m


ApplyOrder = [
    ('standard',  # catches https://bugs.busybox.net/show_bug.cgi?id=11271
     '0001-description.patch',
     '',
     []),
    ('standard with path',
     'path/0001-description.patch',
     '',
     []),
    ('acceptable format',
     '1-description.patch',
     '',
     []),
    ('acceptable format with path',
     'path/1-description.patch',
     '',
     []),
    ('old format',
     'package-0001-description.patch',
     '',
     [['package-0001-description.patch:0: use name <number>-<description>.patch (url#_providing_patches)']]),
    ('old format with path',
     'path/package-0001-description.patch',
     '',
     [['path/package-0001-description.patch:0: use name <number>-<description>.patch (url#_providing_patches)']]),
    ('missing number',
     'description.patch',
     '',
     [['description.patch:0: use name <number>-<description>.patch (url#_providing_patches)']]),
    ('missing number with path',
     'path/description.patch',
     '',
     [['path/description.patch:0: use name <number>-<description>.patch (url#_providing_patches)']]),
    ]


@pytest.mark.parametrize('testname,filename,string,expected', ApplyOrder)
def test_ApplyOrder(testname, filename, string, expected):
    warnings = util.check_file(m.ApplyOrder, filename, string)
    assert warnings == expected


NumberedSubject = [
    ('no subject',
     'patch',
     '',
     []),
    ('acceptable because it is not a git patch',
     'patch',
     'Subject: [PATCH 24/105] text\n',
     []),
    ('good',
     'patch',
     'Subject: [PATCH] text\n'
     'diff --git a/configure.ac b/configure.ac\n',
     []),
    ('bad',
     'patch',
     'Subject: [PATCH 24/105] text\n'
     'diff --git a/configure.ac b/configure.ac\n',
     [["patch:1: generate your patches with 'git format-patch -N'",
       'Subject: [PATCH 24/105] text\n']]),
    ]


@pytest.mark.parametrize('testname,filename,string,expected', NumberedSubject)
def test_NumberedSubject(testname, filename, string, expected):
    warnings = util.check_file(m.NumberedSubject, filename, string)
    assert warnings == expected


Sob = [
    ('good',
     'patch',
     'Signed-off-by: John Doe <johndoe@example.com>\n',
     []),
    ('empty',
     'patch',
     '',
     [['patch:0: missing Signed-off-by in the header (url#_format_and_licensing_of_the_package_patches)']]),
    ('bad',
     'patch',
     'Subject: [PATCH 24/105] text\n',
     [['patch:0: missing Signed-off-by in the header (url#_format_and_licensing_of_the_package_patches)']]),
    ]


@pytest.mark.parametrize('testname,filename,string,expected', Sob)
def test_Sob(testname, filename, string, expected):
    warnings = util.check_file(m.Sob, filename, string)
    assert warnings == expected
