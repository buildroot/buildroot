################################################################################
#
# python-uswid
#
################################################################################

PYTHON_USWID_VERSION = 0.5.1
PYTHON_USWID_SOURCE = uswid-$(PYTHON_USWID_VERSION).tar.gz
PYTHON_USWID_SITE = https://files.pythonhosted.org/packages/5c/67/9244d29d6391d49f30128da6c73a61c7a6c1f8bfcf0181f83298aa050832
PYTHON_USWID_SETUP_TYPE = setuptools
PYTHON_USWID_LICENSE = BSD-2-Clause-Patent
PYTHON_USWID_LICENSE_FILES = LICENSE
HOST_PYTHON_USWID_DEPENDENCIES = \
	host-python-cbor2 \
	host-python-lxml \
	host-python-pefile

$(eval $(host-python-package))
