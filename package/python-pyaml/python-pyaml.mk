################################################################################
#
# python-pyaml
#
################################################################################

PYTHON_PYAML_VERSION = 26.2.1
PYTHON_PYAML_SOURCE = pyaml-$(PYTHON_PYAML_VERSION).tar.gz
PYTHON_PYAML_SITE = https://files.pythonhosted.org/packages/38/fb/2b9590512a9d7763620d87171c7531d5295678ce96e57393614b91da8998
PYTHON_PYAML_SETUP_TYPE = setuptools
PYTHON_PYAML_LICENSE = WTFPL
PYTHON_PYAML_LICENSE_FILES = COPYING

$(eval $(python-package))
