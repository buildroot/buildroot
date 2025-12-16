################################################################################
#
# python-zopfli
#
################################################################################

PYTHON_ZOPFLI_VERSION = 0.4.0
PYTHON_ZOPFLI_SOURCE = zopfli-$(PYTHON_ZOPFLI_VERSION).tar.gz
PYTHON_ZOPFLI_SITE = https://files.pythonhosted.org/packages/be/4c/efa0760686d4cc69e68a8f284d3c6c5884722c50f810af0e277fb7d61621
PYTHON_ZOPFLI_SETUP_TYPE = setuptools
PYTHON_ZOPFLI_LICENSE = Apache-2.0
PYTHON_ZOPFLI_LICENSE_FILES = COPYING
PYTHON_ZOPFLI_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
