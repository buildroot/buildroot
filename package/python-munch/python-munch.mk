################################################################################
#
# python-munch
#
################################################################################

PYTHON_MUNCH_VERSION = 4.0.0
PYTHON_MUNCH_SOURCE = munch-$(PYTHON_MUNCH_VERSION).tar.gz
PYTHON_MUNCH_SITE = https://files.pythonhosted.org/packages/e7/2b/45098135b5f9f13221820d90f9e0516e11a2a0f55012c13b081d202b782a
PYTHON_MUNCH_SETUP_TYPE = setuptools
PYTHON_MUNCH_LICENSE = MIT
PYTHON_MUNCH_LICENSE_FILES = LICENSE.txt
PYTHON_MUNCH_DEPENDENCIES = host-python-pbr

$(eval $(python-package))
