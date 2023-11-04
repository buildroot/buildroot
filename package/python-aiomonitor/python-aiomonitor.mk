################################################################################
#
# python-aiomonitor
#
################################################################################

PYTHON_AIOMONITOR_VERSION = 0.6.0
PYTHON_AIOMONITOR_SOURCE = aiomonitor-$(PYTHON_AIOMONITOR_VERSION).tar.gz
PYTHON_AIOMONITOR_SITE = https://files.pythonhosted.org/packages/13/ab/36fbaf36c1c7cb4d5a81b945faf69e95a48dd38cbc9b57915d41d9445f55
PYTHON_AIOMONITOR_SETUP_TYPE = setuptools
PYTHON_AIOMONITOR_LICENSE = Apache-2.0
PYTHON_AIOMONITOR_LICENSE_FILES = LICENSE
PYTHON_AIOMONITOR_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
