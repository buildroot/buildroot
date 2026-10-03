################################################################################
#
# python-pyspnego
#
################################################################################

PYTHON_PYSPNEGO_VERSION = 0.12.3
PYTHON_PYSPNEGO_SOURCE = pyspnego-$(PYTHON_PYSPNEGO_VERSION).tar.gz
PYTHON_PYSPNEGO_SITE = https://files.pythonhosted.org/packages/fd/8f/30bb9568554899a6147bed657762a3c707e2d3dcaabf3492161cc9550bb4
PYTHON_PYSPNEGO_SETUP_TYPE = setuptools
PYTHON_PYSPNEGO_LICENSE = MIT
PYTHON_PYSPNEGO_LICENSE_FILES = LICENSE

$(eval $(python-package))
