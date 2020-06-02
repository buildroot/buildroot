################################################################################
#
# python-markdown2
#
################################################################################

PYTHON_MARKDOWN2_VERSION = 2.3.9
PYTHON_MARKDOWN2_SOURCE = markdown2-$(PYTHON_MARKDOWN2_VERSION).tar.gz
PYTHON_MARKDOWN2_SITE = https://files.pythonhosted.org/packages/14/69/c542025f80916457ff4fe962404a27ab6417d43822fe54bf88ee2dd1b36f
PYTHON_MARKDOWN2_SETUP_TYPE = setuptools
PYTHON_MARKDOWN2_LICENSE = MIT
PYTHON_MARKDOWN2_LICENSE_FILES = LICENSE.txt

# 0001-Fix-for-issue-348-incomplete-tags-with-punctuation-after-as-part-of.patch
# 0002-Better-fix-for-issue-348.patch
PYTHON_MARKDOWN2_IGNORE_CVES += CVE-2020-11888

$(eval $(python-package))
