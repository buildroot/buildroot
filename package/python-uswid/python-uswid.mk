################################################################################
#
# python-uswid
#
################################################################################

PYTHON_USWID_VERSION = 0.5.2
PYTHON_USWID_SOURCE = uswid-$(PYTHON_USWID_VERSION).tar.gz
PYTHON_USWID_SITE = https://files.pythonhosted.org/packages/15/64/d200424bf8f87ef25b516d438d745b03aa4ec381756d86cc3ff6bf29393c
PYTHON_USWID_SETUP_TYPE = setuptools
PYTHON_USWID_LICENSE = BSD-2-Clause-Patent
PYTHON_USWID_LICENSE_FILES = LICENSE
HOST_PYTHON_USWID_DEPENDENCIES = \
	host-python-cbor2 \
	host-python-lxml \
	host-python-pefile

$(eval $(host-python-package))
