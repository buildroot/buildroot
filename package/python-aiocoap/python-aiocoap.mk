################################################################################
#
# python-aiocoap
#
################################################################################

PYTHON_AIOCOAP_VERSION = 0.4.5
PYTHON_AIOCOAP_SOURCE = aiocoap-$(PYTHON_AIOCOAP_VERSION).tar.gz
PYTHON_AIOCOAP_SITE = https://files.pythonhosted.org/packages/65/63/9051af6a2fc498f50b71f23bdbde0cc1d1f0a69eb767776dbf6d1411e240
PYTHON_AIOCOAP_SETUP_TYPE = setuptools
PYTHON_AIOCOAP_LICENSE = MIT
PYTHON_AIOCOAP_LICENSE_FILES = LICENSE

$(eval $(python-package))
