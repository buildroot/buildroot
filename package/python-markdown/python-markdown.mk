################################################################################
#
# python-markdown
#
################################################################################

PYTHON_MARKDOWN_VERSION = 3.11.2
PYTHON_MARKDOWN_SOURCE = markdown-$(PYTHON_MARKDOWN_VERSION).tar.gz
PYTHON_MARKDOWN_SITE = https://files.pythonhosted.org/packages/f4/32/0b4d0297064244f04af4331b65de16237cc3cce07474171ee14222a28981
PYTHON_MARKDOWN_LICENSE = BSD-3-Clause
PYTHON_MARKDOWN_LICENSE_FILES = LICENSE.md
PYTHON_MARKDOWN_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
