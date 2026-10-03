################################################################################
#
# python-pyspnego
#
################################################################################

PYTHON_PYSPNEGO_VERSION = 0.12.2
PYTHON_PYSPNEGO_SOURCE = pyspnego-$(PYTHON_PYSPNEGO_VERSION).tar.gz
PYTHON_PYSPNEGO_SITE = https://files.pythonhosted.org/packages/03/c4/790211e7a2180509dc29137c488c7b038ef89bdf83db0ce4da802f64f9d4
PYTHON_PYSPNEGO_SETUP_TYPE = setuptools
PYTHON_PYSPNEGO_LICENSE = MIT
PYTHON_PYSPNEGO_LICENSE_FILES = LICENSE

$(eval $(python-package))
