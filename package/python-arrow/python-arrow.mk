################################################################################
#
# python-arrow
#
################################################################################

PYTHON_ARROW_VERSION = 1.2.3
PYTHON_ARROW_SOURCE = arrow-$(PYTHON_ARROW_VERSION).tar.gz
PYTHON_ARROW_SITE = https://files.pythonhosted.org/packages/7f/c0/c601ea7811f422700ef809f167683899cdfddec5aa3f83597edf97349962
PYTHON_ARROW_SETUP_TYPE = setuptools
PYTHON_ARROW_LICENSE = Apache-2.0
PYTHON_ARROW_LICENSE_FILES = LICENSE

$(eval $(python-package))
