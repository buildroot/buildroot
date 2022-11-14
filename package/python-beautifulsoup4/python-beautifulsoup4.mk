################################################################################
#
# python-beautifulsoup4
#
################################################################################

PYTHON_BEAUTIFULSOUP4_VERSION = 4.10.0
PYTHON_BEAUTIFULSOUP4_SOURCE = beautifulsoup4-$(PYTHON_BEAUTIFULSOUP4_VERSION).tar.gz
PYTHON_BEAUTIFULSOUP4_SITE = https://files.pythonhosted.org/packages/a1/69/daeee6d8f22c997e522cdbeb59641c4d31ab120aba0f2c799500f7456b7e
PYTHON_BEAUTIFULSOUP4_SETUP_TYPE = setuptools
PYTHON_BEAUTIFULSOUP4_LICENSE = MIT
PYTHON_BEAUTIFULSOUP4_LICENSE_FILES = COPYING.txt

$(eval $(python-package))
