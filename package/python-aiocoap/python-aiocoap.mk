################################################################################
#
# python-aiocoap
#
################################################################################

PYTHON_AIOCOAP_VERSION = 0.4.7
PYTHON_AIOCOAP_SOURCE = aiocoap-$(PYTHON_AIOCOAP_VERSION).tar.gz
PYTHON_AIOCOAP_SITE = https://files.pythonhosted.org/packages/de/14/843232b56c0f09b2ceddae3da37598d9109c4b1d9383b1ab72232018e9e8
PYTHON_AIOCOAP_SETUP_TYPE = setuptools
PYTHON_AIOCOAP_LICENSE = MIT
PYTHON_AIOCOAP_LICENSE_FILES = doc/LICENSE.rst

$(eval $(python-package))
