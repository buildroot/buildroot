################################################################################
#
# python-bleak
#
################################################################################

PYTHON_BLEAK_VERSION = 0.20.0
PYTHON_BLEAK_SOURCE = bleak-$(PYTHON_BLEAK_VERSION).tar.gz
PYTHON_BLEAK_SITE = https://files.pythonhosted.org/packages/aa/86/5084561ed4f31aec0322bef015db949a9f2bf0b4f6bd72b16479cf03f459
PYTHON_BLEAK_SETUP_TYPE = setuptools
PYTHON_BLEAK_LICENSE = MIT
PYTHON_BLEAK_LICENSE_FILES = LICENSE

$(eval $(python-package))
