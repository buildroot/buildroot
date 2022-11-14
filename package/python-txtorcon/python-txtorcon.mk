################################################################################
#
# python-txtorcon
#
################################################################################

PYTHON_TXTORCON_VERSION = 21.1.0
PYTHON_TXTORCON_SOURCE = txtorcon-$(PYTHON_TXTORCON_VERSION).tar.gz
PYTHON_TXTORCON_SITE = https://files.pythonhosted.org/packages/eb/43/2426009377cef519c53bdc8969590cb100e9fd745846859963c881c6d176
PYTHON_TXTORCON_SETUP_TYPE = setuptools
PYTHON_TXTORCON_LICENSE = MIT
PYTHON_TXTORCON_LICENSE_FILES = LICENSE

$(eval $(python-package))
