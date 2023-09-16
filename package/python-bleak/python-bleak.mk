################################################################################
#
# python-bleak
#
################################################################################

PYTHON_BLEAK_VERSION = 0.21.1
PYTHON_BLEAK_SOURCE = bleak-$(PYTHON_BLEAK_VERSION).tar.gz
PYTHON_BLEAK_SITE = https://files.pythonhosted.org/packages/6a/c0/3aca655fa43b8ff5340d99fac4e67061f53f42f092fc847bdd0559d67846
PYTHON_BLEAK_SETUP_TYPE = setuptools
PYTHON_BLEAK_LICENSE = MIT
PYTHON_BLEAK_LICENSE_FILES = LICENSE

$(eval $(python-package))
