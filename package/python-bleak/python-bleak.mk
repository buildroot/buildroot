################################################################################
#
# python-bleak
#
################################################################################

PYTHON_BLEAK_VERSION = 0.12.1
PYTHON_BLEAK_SOURCE = bleak-$(PYTHON_BLEAK_VERSION).tar.gz
PYTHON_BLEAK_SITE = https://files.pythonhosted.org/packages/67/4b/ba00c69a24a8d08c86f02caa45727a2ad2844c7bee9630ccb063be226f71
PYTHON_BLEAK_SETUP_TYPE = setuptools
PYTHON_BLEAK_LICENSE = MIT
PYTHON_BLEAK_LICENSE_FILES = LICENSE

$(eval $(python-package))
