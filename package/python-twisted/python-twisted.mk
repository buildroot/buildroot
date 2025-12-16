################################################################################
#
# python-twisted
#
################################################################################

PYTHON_TWISTED_VERSION = 25.5.0
PYTHON_TWISTED_SOURCE = twisted-$(PYTHON_TWISTED_VERSION).tar.gz
PYTHON_TWISTED_SITE = https://files.pythonhosted.org/packages/13/0f/82716ed849bf7ea4984c21385597c949944f0f9b428b5710f79d0afc084d
PYTHON_TWISTED_SETUP_TYPE = hatch
PYTHON_TWISTED_LICENSE = MIT
PYTHON_TWISTED_LICENSE_FILES = LICENSE
PYTHON_TWISTED_CPE_ID_VENDOR = twisted
PYTHON_TWISTED_CPE_ID_PRODUCT = twisted
PYTHON_TWISTED_DEPENDENCIES = \
	host-python-hatch-fancy-pypi-readme \
	host-python-incremental

$(eval $(python-package))
