################################################################################
#
# python-pyspnego
#
################################################################################

PYTHON_PYSPNEGO_VERSION = 0.6.3
PYTHON_PYSPNEGO_SOURCE = pyspnego-$(PYTHON_PYSPNEGO_VERSION).tar.gz
PYTHON_PYSPNEGO_SITE = https://files.pythonhosted.org/packages/ba/13/7b4e7dcff1eb24a13e0a631a4b49eab361678e4490d691c03253ae736da4
PYTHON_PYSPNEGO_SETUP_TYPE = setuptools
PYTHON_PYSPNEGO_LICENSE = MIT
PYTHON_PYSPNEGO_LICENSE_FILES = LICENSE

$(eval $(python-package))
