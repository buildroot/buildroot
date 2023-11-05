################################################################################
#
# python-engineio
#
################################################################################

PYTHON_ENGINEIO_VERSION = 4.8.0
PYTHON_ENGINEIO_SITE = https://files.pythonhosted.org/packages/c4/5c/4fa0bf79eb1a433d1e9b69430b3ac818837283c642640658f12949620813
PYTHON_ENGINEIO_SETUP_TYPE = setuptools
PYTHON_ENGINEIO_LICENSE = MIT
PYTHON_ENGINEIO_LICENSE_FILES = LICENSE
PYTHON_ENGINEIO_CPE_ID_VENDOR = python-engineio_project

$(eval $(python-package))
