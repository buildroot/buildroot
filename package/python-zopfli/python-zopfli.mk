################################################################################
#
# python-zopfli
#
################################################################################

PYTHON_ZOPFLI_VERSION = 0.2.3.post1
PYTHON_ZOPFLI_SOURCE = zopfli-$(PYTHON_ZOPFLI_VERSION).tar.gz
PYTHON_ZOPFLI_SITE = https://files.pythonhosted.org/packages/5e/7c/a8f6696e694709e2abcbccd27d05ef761e9b6efae217e11d977471555b62
PYTHON_ZOPFLI_SETUP_TYPE = setuptools
PYTHON_ZOPFLI_LICENSE = Apache-2.0
PYTHON_ZOPFLI_LICENSE_FILES = COPYING
PYTHON_ZOPFLI_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
