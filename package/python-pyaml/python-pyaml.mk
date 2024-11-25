################################################################################
#
# python-pyaml
#
################################################################################

PYTHON_PYAML_VERSION = 24.9.0
PYTHON_PYAML_SOURCE = pyaml-$(PYTHON_PYAML_VERSION).tar.gz
PYTHON_PYAML_SITE = https://files.pythonhosted.org/packages/fd/a6/5b51160ff7ce60b0c60ec825359c0e818b0ce4a2504fa3dd1470f42f9b10
PYTHON_PYAML_SETUP_TYPE = setuptools
PYTHON_PYAML_LICENSE = WTFPL
PYTHON_PYAML_LICENSE_FILES = COPYING

$(eval $(python-package))
