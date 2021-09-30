################################################################################
#
# python-inflection
#
################################################################################

PYTHON_INFLECTION_VERSION = 0.5.1
PYTHON_INFLECTION_SOURCE = inflection-$(PYTHON_INFLECTION_VERSION).tar.gz
PYTHON_INFLECTION_SITE = https://files.pythonhosted.org/packages/e1/7e/691d061b7329bc8d54edbf0ec22fbfb2afe61facb681f9aaa9bff7a27d04
PYTHON_INFLECTION_SETUP_TYPE = setuptools
PYTHON_INFLECTION_LICENSE = MIT
PYTHON_INFLECTION_LICENSE_FILES = LICENSE
HOST_PYTHON_INFLECTION_NEEDS_HOST_PYTHON = python3

$(eval $(python-package))
$(eval $(host-python-package))
