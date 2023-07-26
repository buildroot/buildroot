################################################################################
#
# python-pylibfdt
#
################################################################################

PYTHON_PYLIBFDT_VERSION = 1.6.1
PYTHON_PYLIBFDT_SOURCE = pylibfdt-$(PYTHON_PYLIBFDT_VERSION).tar.gz
PYTHON_PYLIBFDT_SITE = https://files.pythonhosted.org/packages/15/3c/40b1d6a1df9dbc9d9ba5700a47ad95ca1e984f18daf25ede0da5f67d0cf7
PYTHON_PYLIBFDT_SETUP_TYPE = setuptools
PYTHON_PYLIBFDT_LICENSE = BSD-2-Clause or GPL-2.0+
PYTHON_PYLIBFDT_LICENSE_FILES = BSD-2-Clause GPL
PYTHON_PYLIBFDT_DEPENDENCIES = host-python-setuptools-scm host-swig
HOST_PYTHON_PYLIBFDT_DEPENDENCIES = host-python-setuptools-scm host-swig

$(eval $(python-package))
$(eval $(host-python-package))
