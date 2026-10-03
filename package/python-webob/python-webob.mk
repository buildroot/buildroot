################################################################################
#
# python-webob
#
################################################################################

PYTHON_WEBOB_VERSION = 1.8.11
PYTHON_WEBOB_SOURCE = webob-$(PYTHON_WEBOB_VERSION).tar.gz
PYTHON_WEBOB_SITE = https://files.pythonhosted.org/packages/e6/92/9329872e36be90e25ba616ac6e9ee8c1be4326a1ea3fdffcdabd0eb48efb
PYTHON_WEBOB_SETUP_TYPE = setuptools
PYTHON_WEBOB_LICENSE = MIT
PYTHON_WEBOB_LICENSE_FILES = docs/license.txt

$(eval $(python-package))
