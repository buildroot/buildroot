################################################################################
#
# python-twisted
#
################################################################################

PYTHON_TWISTED_VERSION = 26.10.0
PYTHON_TWISTED_SOURCE = twisted-$(PYTHON_TWISTED_VERSION).tar.gz
PYTHON_TWISTED_SITE = https://files.pythonhosted.org/packages/fe/31/a5f99ae7f1550914b0702b8f78118d95a79da20525d26fbc1b2ab42bc8ae
PYTHON_TWISTED_SETUP_TYPE = hatch
PYTHON_TWISTED_LICENSE = MIT
PYTHON_TWISTED_LICENSE_FILES = LICENSE
PYTHON_TWISTED_CPE_ID_VENDOR = twisted
PYTHON_TWISTED_CPE_ID_PRODUCT = twisted
PYTHON_TWISTED_DEPENDENCIES = \
	host-python-hatch-fancy-pypi-readme \
	host-python-incremental

$(eval $(python-package))
