################################################################################
#
# python-apispec
#
################################################################################

PYTHON_APISPEC_VERSION = 6.7.0
PYTHON_APISPEC_SOURCE = apispec-$(PYTHON_APISPEC_VERSION).tar.gz
PYTHON_APISPEC_SITE = https://files.pythonhosted.org/packages/7c/09/2d5b33f12feb18375c11c6ca518be49a8355e4be3a3581b27a7faf83983b
PYTHON_APISPEC_SETUP_TYPE = flit
PYTHON_APISPEC_LICENSE = MIT
PYTHON_APISPEC_LICENSE_FILES = LICENSE

$(eval $(python-package))
