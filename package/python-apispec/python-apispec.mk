################################################################################
#
# python-apispec
#
################################################################################

PYTHON_APISPEC_VERSION = 6.0.2
PYTHON_APISPEC_SOURCE = apispec-$(PYTHON_APISPEC_VERSION).tar.gz
PYTHON_APISPEC_SITE = https://files.pythonhosted.org/packages/a7/2a/b42c17e0d653341b8f5916999892cd2d8489de127dac6118ae44531674f5
PYTHON_APISPEC_SETUP_TYPE = setuptools
PYTHON_APISPEC_LICENSE = MIT
PYTHON_APISPEC_LICENSE_FILES = LICENSE

$(eval $(python-package))
