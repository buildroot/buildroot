################################################################################
#
# python-libconf
#
################################################################################

PYTHON_LIBCONF_VERSION = 2.0.1
PYTHON_LIBCONF_SOURCE = libconf-$(PYTHON_LIBCONF_VERSION).tar.gz
PYTHON_LIBCONF_SITE = https://files.pythonhosted.org/packages/c8/41/592c24b42ec6e349629f2b6310ff31255b213bc696c0e4ad2ee1d2bbb68e
PYTHON_LIBCONF_SETUP_TYPE = setuptools
PYTHON_LIBCONF_LICENSE = MIT
PYTHON_LIBCONF_LICENSE_FILES = LICENSE

$(eval $(python-package))
$(eval $(host-python-package))
