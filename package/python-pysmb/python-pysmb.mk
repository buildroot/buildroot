################################################################################
#
# python-pysmb
#
################################################################################

PYTHON_PYSMB_VERSION = 1.2.15
PYTHON_PYSMB_SOURCE = pysmb-$(PYTHON_PYSMB_VERSION).tar.gz
PYTHON_PYSMB_SITE = https://files.pythonhosted.org/packages/9d/84/f5158ec04fdd813aa4f8df229a5f6319f20c6a555adb3967a33d69e24347
PYTHON_PYSMB_LICENSE = Libpng
PYTHON_PYSMB_LICENSE_FILES = LICENSE
PYTHON_PYSMB_SETUP_TYPE = setuptools

$(eval $(python-package))
