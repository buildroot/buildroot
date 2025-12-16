################################################################################
#
# python-wsproto
#
################################################################################

PYTHON_WSPROTO_VERSION = 1.3.2
PYTHON_WSPROTO_SOURCE = wsproto-$(PYTHON_WSPROTO_VERSION).tar.gz
PYTHON_WSPROTO_SITE = https://files.pythonhosted.org/packages/c7/79/12135bdf8b9c9367b8701c2c19a14c913c120b882d50b014ca0d38083c2c
PYTHON_WSPROTO_SETUP_TYPE = setuptools
PYTHON_WSPROTO_LICENSE = MIT
PYTHON_WSPROTO_LICENSE_FILES = LICENSE

$(eval $(python-package))
