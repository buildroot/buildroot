################################################################################
#
# python-markdown
#
################################################################################

PYTHON_MARKDOWN_VERSION = 3.11.1
PYTHON_MARKDOWN_SOURCE = markdown-$(PYTHON_MARKDOWN_VERSION).tar.gz
PYTHON_MARKDOWN_SITE = https://files.pythonhosted.org/packages/4e/d4/f3f4b6ed70b7c7608fa026ff3bbe59ace9b1ebca43d8ae4886c87c95e81d
PYTHON_MARKDOWN_LICENSE = BSD-3-Clause
PYTHON_MARKDOWN_LICENSE_FILES = LICENSE.md
PYTHON_MARKDOWN_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
