################################################################################
#
# python-pyaml
#
################################################################################

PYTHON_PYAML_VERSION = 25.1.0
PYTHON_PYAML_SOURCE = pyaml-$(PYTHON_PYAML_VERSION).tar.gz
PYTHON_PYAML_SITE = https://files.pythonhosted.org/packages/f4/06/04b9c1907c13dc81729a9c6b4f42eab47baab7a8738ed5d2683eac215ad0
PYTHON_PYAML_SETUP_TYPE = setuptools
PYTHON_PYAML_LICENSE = WTFPL
PYTHON_PYAML_LICENSE_FILES = COPYING

$(eval $(python-package))
