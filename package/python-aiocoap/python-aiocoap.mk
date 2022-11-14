################################################################################
#
# python-aiocoap
#
################################################################################

PYTHON_AIOCOAP_VERSION = 0.4.1
PYTHON_AIOCOAP_SOURCE = aiocoap-$(PYTHON_AIOCOAP_VERSION).tar.gz
PYTHON_AIOCOAP_SITE = https://files.pythonhosted.org/packages/67/1c/6d6764010a4779d61bc7241afa663b368261c72af20555b26efc875d4276
PYTHON_AIOCOAP_SETUP_TYPE = setuptools
PYTHON_AIOCOAP_LICENSE = MIT
PYTHON_AIOCOAP_LICENSE_FILES = LICENSE

$(eval $(python-package))
