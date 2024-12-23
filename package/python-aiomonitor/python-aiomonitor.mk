################################################################################
#
# python-aiomonitor
#
################################################################################

PYTHON_AIOMONITOR_VERSION = 0.7.1
PYTHON_AIOMONITOR_SOURCE = aiomonitor-$(PYTHON_AIOMONITOR_VERSION).tar.gz
PYTHON_AIOMONITOR_SITE = https://files.pythonhosted.org/packages/28/0a/805797608db4e30ab588b283137b5b2a735655c20df72f2f9bac41da789e
PYTHON_AIOMONITOR_SETUP_TYPE = setuptools
PYTHON_AIOMONITOR_LICENSE = Apache-2.0
PYTHON_AIOMONITOR_LICENSE_FILES = LICENSE
PYTHON_AIOMONITOR_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
