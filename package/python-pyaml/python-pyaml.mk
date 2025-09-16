################################################################################
#
# python-pyaml
#
################################################################################

PYTHON_PYAML_VERSION = 25.7.0
PYTHON_PYAML_SOURCE = pyaml-$(PYTHON_PYAML_VERSION).tar.gz
PYTHON_PYAML_SITE = https://files.pythonhosted.org/packages/c4/01/41f63d66a801a561c9e335523516bd5f761bc43cc61f8b75918306bf2da8
PYTHON_PYAML_SETUP_TYPE = setuptools
PYTHON_PYAML_LICENSE = WTFPL
PYTHON_PYAML_LICENSE_FILES = COPYING

$(eval $(python-package))
