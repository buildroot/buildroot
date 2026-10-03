################################################################################
#
# python-pyaml
#
################################################################################

PYTHON_PYAML_VERSION = 26.7.0
PYTHON_PYAML_SOURCE = pyaml-$(PYTHON_PYAML_VERSION).tar.gz
PYTHON_PYAML_SITE = https://files.pythonhosted.org/packages/15/6a/acfdf17de0d6947b419da8696e02b781b18de2cf49e0472298b50e1f0711
PYTHON_PYAML_SETUP_TYPE = setuptools
PYTHON_PYAML_LICENSE = WTFPL
PYTHON_PYAML_LICENSE_FILES = COPYING

$(eval $(python-package))
