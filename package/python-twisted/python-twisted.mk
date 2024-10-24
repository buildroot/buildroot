################################################################################
#
# python-twisted
#
################################################################################

PYTHON_TWISTED_VERSION = 24.7.0
PYTHON_TWISTED_SOURCE = twisted-$(PYTHON_TWISTED_VERSION).tar.gz
PYTHON_TWISTED_SITE = https://files.pythonhosted.org/packages/8b/bf/f30eb89bcd14a21a36b4cd3d96658432d4c590af3c24bbe08ea77fa7bbbb
PYTHON_TWISTED_SETUP_TYPE = hatch
PYTHON_TWISTED_LICENSE = MIT
PYTHON_TWISTED_LICENSE_FILES = LICENSE
PYTHON_TWISTED_CPE_ID_VENDOR = twistedmatrix
PYTHON_TWISTED_CPE_ID_PRODUCT = twisted
PYTHON_TWISTED_DEPENDENCIES = \
	host-python-hatch-fancy-pypi-readme \
	host-python-incremental

$(eval $(python-package))
