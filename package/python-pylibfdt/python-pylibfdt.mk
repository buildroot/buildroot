################################################################################
#
# python-pylibfdt
#
################################################################################

PYTHON_PYLIBFDT_VERSION = 1.7.2
PYTHON_PYLIBFDT_SOURCE = pylibfdt-$(PYTHON_PYLIBFDT_VERSION).tar.gz
PYTHON_PYLIBFDT_SITE = https://files.pythonhosted.org/packages/b1/cc/54fc80135b3eb7fcbfded65eee7c71b2b970b5124e3066a158421222f191
PYTHON_PYLIBFDT_SETUP_TYPE = pep517
PYTHON_PYLIBFDT_LICENSE = BSD-2-Clause or GPL-2.0+
PYTHON_PYLIBFDT_LICENSE_FILES = BSD-2-Clause GPL
PYTHON_PYLIBFDT_DEPENDENCIES = host-python-setuptools-scm host-swig
PYTHON_PYLIBFDT_BUILD_OPTS = --skip-dependency-check
HOST_PYTHON_PYLIBFDT_DEPENDENCIES = host-python-setuptools-scm host-swig
HOST_PYTHON_PYLIBFDT_BUILD_OPTS = --skip-dependency-check

$(eval $(python-package))
$(eval $(host-python-package))
