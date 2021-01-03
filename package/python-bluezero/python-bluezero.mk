################################################################################
#
# python-bluezero
#
################################################################################

PYTHON_BLUEZERO_VERSION = 0.4.0
PYTHON_BLUEZERO_SOURCE = bluezero-$(PYTHON_BLUEZERO_VERSION).tar.gz
PYTHON_BLUEZERO_SITE = https://files.pythonhosted.org/packages/14/ee/ac038391cf41838ff724e8a11d939e86329043724a7cfd03152f13688bd7
PYTHON_BLUEZERO_SETUP_TYPE = setuptools
PYTHON_BLUEZERO_LICENSE = MIT
PYTHON_BLUEZERO_LICENSE_FILES = LICENSE

$(eval $(python-package))
