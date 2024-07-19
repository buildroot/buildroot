################################################################################
#
# python-pefile
#
################################################################################

PYTHON_PEFILE_VERSION = 2023.2.7
PYTHON_PEFILE_SOURCE = pefile-$(PYTHON_PEFILE_VERSION).tar.gz
PYTHON_PEFILE_SITE = https://files.pythonhosted.org/packages/78/c5/3b3c62223f72e2360737fd2a57c30e5b2adecd85e70276879609a7403334
PYTHON_PEFILE_SETUP_TYPE = setuptools
PYTHON_PEFILE_LICENSE = MIT
PYTHON_PEFILE_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
