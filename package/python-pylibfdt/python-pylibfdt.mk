################################################################################
#
# python-pylibfdt
#
################################################################################

PYTHON_PYLIBFDT_VERSION = 1.7.2.post1
PYTHON_PYLIBFDT_SOURCE = pylibfdt-$(PYTHON_PYLIBFDT_VERSION).tar.gz
PYTHON_PYLIBFDT_SITE = https://files.pythonhosted.org/packages/a2/b8/ef881f0e76af7727ca9c5e27a121db69667c69e4e91eceaafe97f3666a6c
PYTHON_PYLIBFDT_SETUP_TYPE = pep517
PYTHON_PYLIBFDT_LICENSE = BSD-2-Clause or GPL-2.0+
PYTHON_PYLIBFDT_LICENSE_FILES = BSD-2-Clause GPL
PYTHON_PYLIBFDT_DEPENDENCIES = host-python-setuptools-scm host-swig
PYTHON_PYLIBFDT_BUILD_OPTS = --skip-dependency-check
HOST_PYTHON_PYLIBFDT_DEPENDENCIES = host-python-setuptools-scm host-swig
HOST_PYTHON_PYLIBFDT_BUILD_OPTS = --skip-dependency-check

$(eval $(python-package))
$(eval $(host-python-package))
