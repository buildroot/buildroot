################################################################################
#
# python-apispec
#
################################################################################

PYTHON_APISPEC_VERSION = 6.3.0
PYTHON_APISPEC_SOURCE = apispec-$(PYTHON_APISPEC_VERSION).tar.gz
PYTHON_APISPEC_SITE = https://files.pythonhosted.org/packages/3f/1e/207c3e61c805eef214d7e5c58106312f9af4733b07f470224e4e309dc65e
PYTHON_APISPEC_SETUP_TYPE = setuptools
PYTHON_APISPEC_LICENSE = MIT
PYTHON_APISPEC_LICENSE_FILES = LICENSE

$(eval $(python-package))
