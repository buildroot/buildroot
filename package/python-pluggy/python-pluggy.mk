################################################################################
#
# python-pluggy
#
################################################################################

PYTHON_PLUGGY_VERSION = 1.5.0
PYTHON_PLUGGY_SOURCE = pluggy-$(PYTHON_PLUGGY_VERSION).tar.gz
PYTHON_PLUGGY_SITE = https://files.pythonhosted.org/packages/96/2d/02d4312c973c6050a18b314a5ad0b3210edb65a906f868e31c111dede4a6
PYTHON_PLUGGY_SETUP_TYPE = setuptools
PYTHON_PLUGGY_LICENSE = MIT
PYTHON_PLUGGY_LICENSE_FILES = LICENSE
PYTHON_PLUGGY_DEPENDENCIES = host-python-setuptools-scm
HOST_PYTHON_PLUGGY_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
$(eval $(host-python-package))
