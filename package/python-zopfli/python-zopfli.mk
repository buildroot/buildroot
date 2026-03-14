################################################################################
#
# python-zopfli
#
################################################################################

PYTHON_ZOPFLI_VERSION = 0.4.1
PYTHON_ZOPFLI_SOURCE = zopfli-$(PYTHON_ZOPFLI_VERSION).tar.gz
PYTHON_ZOPFLI_SITE = https://files.pythonhosted.org/packages/0a/4d/a8cc1768b2eda3c0c7470bf8059dcb94ef96d45dd91fc6edd29430d44072
PYTHON_ZOPFLI_SETUP_TYPE = setuptools
PYTHON_ZOPFLI_LICENSE = Apache-2.0
PYTHON_ZOPFLI_LICENSE_FILES = COPYING
PYTHON_ZOPFLI_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
