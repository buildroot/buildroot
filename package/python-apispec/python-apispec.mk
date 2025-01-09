################################################################################
#
# python-apispec
#
################################################################################

PYTHON_APISPEC_VERSION = 6.8.1
PYTHON_APISPEC_SOURCE = apispec-$(PYTHON_APISPEC_VERSION).tar.gz
PYTHON_APISPEC_SITE = https://files.pythonhosted.org/packages/74/38/62499ad75cf085f5268458c09ae97007082ed85aec1a9cd9e38f7685fbb0
PYTHON_APISPEC_SETUP_TYPE = flit
PYTHON_APISPEC_LICENSE = MIT
PYTHON_APISPEC_LICENSE_FILES = LICENSE

$(eval $(python-package))
