################################################################################
#
# python-pylibfdt
#
################################################################################

PYTHON_PYLIBFDT_VERSION = 1.7.0.post1
PYTHON_PYLIBFDT_SOURCE = pylibfdt-$(PYTHON_PYLIBFDT_VERSION).tar.gz
PYTHON_PYLIBFDT_SITE = https://files.pythonhosted.org/packages/96/5c/77ef0f0459e0b13f39ecc22e21ad4ac9fbe741e8a7cd70702ac8165f80e2
PYTHON_PYLIBFDT_SETUP_TYPE = pep517
PYTHON_PYLIBFDT_LICENSE = BSD-2-Clause or GPL-2.0+
PYTHON_PYLIBFDT_LICENSE_FILES = BSD-2-Clause GPL
PYTHON_PYLIBFDT_DEPENDENCIES = host-python-setuptools-scm host-swig
HOST_PYTHON_PYLIBFDT_DEPENDENCIES = host-python-setuptools-scm host-swig

$(eval $(python-package))
$(eval $(host-python-package))
