################################################################################
#
# python-uswid
#
################################################################################

PYTHON_USWID_VERSION = 0.5.0
PYTHON_USWID_SOURCE = uswid-$(PYTHON_USWID_VERSION).tar.gz
PYTHON_USWID_SITE = https://files.pythonhosted.org/packages/dc/bf/05291df12037befeacda2083c798e98691043978e07ca4a00b4eb94aeb61
PYTHON_USWID_SETUP_TYPE = setuptools
PYTHON_USWID_LICENSE = BSD-2-Clause-Patent
PYTHON_USWID_LICENSE_FILES = LICENSE
HOST_PYTHON_USWID_DEPENDENCIES = \
	host-python-cbor2 \
	host-python-lxml \
	host-python-pefile

$(eval $(host-python-package))
