################################################################################
#
# python-markdown
#
################################################################################

PYTHON_MARKDOWN_VERSION = 3.4.1
PYTHON_MARKDOWN_SOURCE = Markdown-$(PYTHON_MARKDOWN_VERSION).tar.gz
PYTHON_MARKDOWN_SITE = https://files.pythonhosted.org/packages/85/7e/133e943e97a943d2f1d8bae0c5060f8ac50e6691754eb9dbe036b047a9bb
PYTHON_MARKDOWN_LICENSE = BSD-3-Clause
PYTHON_MARKDOWN_LICENSE_FILES = LICENSE.md
PYTHON_MARKDOWN_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
