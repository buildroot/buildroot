################################################################################
#
# python-pylibfdt
#
################################################################################

PYTHON_PYLIBFDT_VERSION = 1.7.2.post2
PYTHON_PYLIBFDT_SOURCE = pylibfdt-$(PYTHON_PYLIBFDT_VERSION).tar.gz
PYTHON_PYLIBFDT_SITE = https://files.pythonhosted.org/packages/0e/98/a25a6311bae8ccbdd56b3e581405c68ab49c57a1127a7c21b3da3847d4ab
PYTHON_PYLIBFDT_SETUP_TYPE = pep517
PYTHON_PYLIBFDT_LICENSE = BSD-2-Clause or GPL-2.0+
PYTHON_PYLIBFDT_LICENSE_FILES = BSD-2-Clause GPL
PYTHON_PYLIBFDT_DEPENDENCIES = host-python-setuptools-scm host-swig
PYTHON_PYLIBFDT_BUILD_OPTS = --skip-dependency-check
HOST_PYTHON_PYLIBFDT_DEPENDENCIES = host-python-setuptools-scm host-swig
HOST_PYTHON_PYLIBFDT_BUILD_OPTS = --skip-dependency-check

$(eval $(python-package))
$(eval $(host-python-package))
