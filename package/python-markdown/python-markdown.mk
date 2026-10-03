################################################################################
#
# python-markdown
#
################################################################################

PYTHON_MARKDOWN_VERSION = 3.11
PYTHON_MARKDOWN_SOURCE = markdown-$(PYTHON_MARKDOWN_VERSION).tar.gz
PYTHON_MARKDOWN_SITE = https://files.pythonhosted.org/packages/f8/4f/700155c8c20d9e655dd0732b5fc3c7614f291b9148da271d7388e50bf774
PYTHON_MARKDOWN_LICENSE = BSD-3-Clause
PYTHON_MARKDOWN_LICENSE_FILES = LICENSE.md
PYTHON_MARKDOWN_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
