################################################################################
#
# python-wsproto
#
################################################################################

PYTHON_WSPROTO_VERSION = 1.2.0
PYTHON_WSPROTO_SOURCE = wsproto-$(PYTHON_WSPROTO_VERSION).tar.gz
PYTHON_WSPROTO_SITE = https://files.pythonhosted.org/packages/c9/4a/44d3c295350d776427904d73c189e10aeae66d7f555bb2feee16d1e4ba5a
PYTHON_WSPROTO_SETUP_TYPE = setuptools
PYTHON_WSPROTO_LICENSE = MIT
PYTHON_WSPROTO_LICENSE_FILES = LICENSE

$(eval $(python-package))
