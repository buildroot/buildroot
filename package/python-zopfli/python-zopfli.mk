################################################################################
#
# python-zopfli
#
################################################################################

PYTHON_ZOPFLI_VERSION = 0.4.3
PYTHON_ZOPFLI_SOURCE = zopfli-$(PYTHON_ZOPFLI_VERSION).tar.gz
PYTHON_ZOPFLI_SITE = https://files.pythonhosted.org/packages/74/21/3b6af43a663b22b00e738bb0642931a2579e15da6852613d56c6aa535d28
PYTHON_ZOPFLI_SETUP_TYPE = setuptools
PYTHON_ZOPFLI_LICENSE = Apache-2.0
PYTHON_ZOPFLI_LICENSE_FILES = COPYING
PYTHON_ZOPFLI_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
