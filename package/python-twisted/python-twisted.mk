################################################################################
#
# python-twisted
#
################################################################################

PYTHON_TWISTED_VERSION = 24.10.0
PYTHON_TWISTED_SOURCE = twisted-$(PYTHON_TWISTED_VERSION).tar.gz
PYTHON_TWISTED_SITE = https://files.pythonhosted.org/packages/b2/0f/2d0b0dcd52a849db64ff63619aead94ae1091fe4d4d7e100371efe513585
PYTHON_TWISTED_SETUP_TYPE = hatch
PYTHON_TWISTED_LICENSE = MIT
PYTHON_TWISTED_LICENSE_FILES = LICENSE
PYTHON_TWISTED_CPE_ID_VENDOR = twistedmatrix
PYTHON_TWISTED_CPE_ID_PRODUCT = twisted
PYTHON_TWISTED_DEPENDENCIES = \
	host-python-hatch-fancy-pypi-readme \
	host-python-incremental

$(eval $(python-package))
