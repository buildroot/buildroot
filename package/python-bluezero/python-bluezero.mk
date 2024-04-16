################################################################################
#
# python-bluezero
#
################################################################################

PYTHON_BLUEZERO_VERSION = 0.8.0
PYTHON_BLUEZERO_SOURCE = bluezero-$(PYTHON_BLUEZERO_VERSION).tar.gz
PYTHON_BLUEZERO_SITE = https://files.pythonhosted.org/packages/67/e1/15fc417b9828d38aa8e09ba06df61d6889740fe45867510a781df9a8ba35
PYTHON_BLUEZERO_SETUP_TYPE = setuptools
PYTHON_BLUEZERO_LICENSE = MIT
PYTHON_BLUEZERO_LICENSE_FILES = LICENSE

$(eval $(python-package))
