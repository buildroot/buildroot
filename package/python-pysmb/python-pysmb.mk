################################################################################
#
# python-pysmb
#
################################################################################

PYTHON_PYSMB_VERSION = 1.2.13
PYTHON_PYSMB_SOURCE = pysmb-$(PYTHON_PYSMB_VERSION).tar.gz
PYTHON_PYSMB_SITE = https://files.pythonhosted.org/packages/de/79/f9a2f2f3aea92ae5647079fcbf28e3969de9af7953bef10e31898fe435e2
PYTHON_PYSMB_LICENSE = Libpng
PYTHON_PYSMB_LICENSE_FILES = LICENSE
PYTHON_PYSMB_SETUP_TYPE = setuptools

$(eval $(python-package))
