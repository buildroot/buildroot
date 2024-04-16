################################################################################
#
# python-aiomonitor
#
################################################################################

PYTHON_AIOMONITOR_VERSION = 0.7.0
PYTHON_AIOMONITOR_SOURCE = aiomonitor-$(PYTHON_AIOMONITOR_VERSION).tar.gz
PYTHON_AIOMONITOR_SITE = https://files.pythonhosted.org/packages/50/30/1d903b716489c2b5d0a92baccf172f972e97c2de94d4ea41c154287e9b60
PYTHON_AIOMONITOR_SETUP_TYPE = setuptools
PYTHON_AIOMONITOR_LICENSE = Apache-2.0
PYTHON_AIOMONITOR_LICENSE_FILES = LICENSE
PYTHON_AIOMONITOR_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
