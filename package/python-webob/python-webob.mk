################################################################################
#
# python-webob
#
################################################################################

PYTHON_WEBOB_VERSION = 1.8.8
PYTHON_WEBOB_SOURCE = webob-$(PYTHON_WEBOB_VERSION).tar.gz
PYTHON_WEBOB_SITE = https://files.pythonhosted.org/packages/a2/7a/ac5b1ab5636cc3bfc9bab1ed54ff4e8fdeb6367edd911f7337be2248b8ab
PYTHON_WEBOB_SETUP_TYPE = setuptools
PYTHON_WEBOB_LICENSE = MIT
PYTHON_WEBOB_LICENSE_FILES = docs/license.txt

$(eval $(python-package))
