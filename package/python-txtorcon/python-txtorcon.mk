################################################################################
#
# python-txtorcon
#
################################################################################

PYTHON_TXTORCON_VERSION = 26.6.0
PYTHON_TXTORCON_SOURCE = txtorcon-$(PYTHON_TXTORCON_VERSION).tar.gz
PYTHON_TXTORCON_SITE = https://files.pythonhosted.org/packages/0c/59/9b868727e8a41b6b5be4c0dad15b8188b75cb9ca3162aa7cdd20b7cfa808
PYTHON_TXTORCON_SETUP_TYPE = setuptools
PYTHON_TXTORCON_LICENSE = MIT
PYTHON_TXTORCON_LICENSE_FILES = LICENSE

$(eval $(python-package))
