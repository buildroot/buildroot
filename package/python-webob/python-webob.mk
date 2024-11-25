################################################################################
#
# python-webob
#
################################################################################

PYTHON_WEBOB_VERSION = 1.8.9
PYTHON_WEBOB_SOURCE = webob-$(PYTHON_WEBOB_VERSION).tar.gz
PYTHON_WEBOB_SITE = https://files.pythonhosted.org/packages/85/0b/1732085540b01f65e4e7999e15864fe14cd18b12a95731a43fd6fd11b26a
PYTHON_WEBOB_SETUP_TYPE = setuptools
PYTHON_WEBOB_LICENSE = MIT
PYTHON_WEBOB_LICENSE_FILES = docs/license.txt

$(eval $(python-package))
