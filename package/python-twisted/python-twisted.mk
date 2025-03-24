################################################################################
#
# python-twisted
#
################################################################################

PYTHON_TWISTED_VERSION = 24.11.0
PYTHON_TWISTED_SOURCE = twisted-$(PYTHON_TWISTED_VERSION).tar.gz
PYTHON_TWISTED_SITE = https://files.pythonhosted.org/packages/77/1c/e07af0df31229250ab58a943077e4adbd5e227d9f2ac826920416b3e5fa2
PYTHON_TWISTED_SETUP_TYPE = hatch
PYTHON_TWISTED_LICENSE = MIT
PYTHON_TWISTED_LICENSE_FILES = LICENSE
PYTHON_TWISTED_CPE_ID_VENDOR = twisted
PYTHON_TWISTED_CPE_ID_PRODUCT = twisted
PYTHON_TWISTED_DEPENDENCIES = \
	host-python-hatch-fancy-pypi-readme \
	host-python-incremental

$(eval $(python-package))
