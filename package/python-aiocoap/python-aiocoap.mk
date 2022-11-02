################################################################################
#
# python-aiocoap
#
################################################################################

PYTHON_AIOCOAP_VERSION = 0.4.4
PYTHON_AIOCOAP_SOURCE = aiocoap-$(PYTHON_AIOCOAP_VERSION).tar.gz
PYTHON_AIOCOAP_SITE = https://files.pythonhosted.org/packages/6a/7c/139993da8dcdfc86446ee6df65b98c68e40c5fcb0caeff3a6b348d9f7d6f
PYTHON_AIOCOAP_SETUP_TYPE = setuptools
PYTHON_AIOCOAP_LICENSE = MIT
PYTHON_AIOCOAP_LICENSE_FILES = LICENSE

$(eval $(python-package))
