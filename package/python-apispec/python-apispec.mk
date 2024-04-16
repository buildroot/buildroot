################################################################################
#
# python-apispec
#
################################################################################

PYTHON_APISPEC_VERSION = 6.3.1
PYTHON_APISPEC_SOURCE = apispec-$(PYTHON_APISPEC_VERSION).tar.gz
PYTHON_APISPEC_SITE = https://files.pythonhosted.org/packages/ff/0c/e70aa981d8ebe2e8a500a85c923579ce3363feccd704268e6ff8053875dd
PYTHON_APISPEC_SETUP_TYPE = setuptools
PYTHON_APISPEC_LICENSE = MIT
PYTHON_APISPEC_LICENSE_FILES = LICENSE

$(eval $(python-package))
