################################################################################
#
# python-pluggy
#
################################################################################

PYTHON_PLUGGY_VERSION = 1.7.0
PYTHON_PLUGGY_SOURCE = pluggy-$(PYTHON_PLUGGY_VERSION).tar.gz
PYTHON_PLUGGY_SITE = https://files.pythonhosted.org/packages/bf/db/7fc19e6f2dc92a966727031389fc2e08b558f0f25eb7403c1119ad4713cd
PYTHON_PLUGGY_SETUP_TYPE = setuptools
PYTHON_PLUGGY_LICENSE = MIT
PYTHON_PLUGGY_LICENSE_FILES = LICENSE
PYTHON_PLUGGY_DEPENDENCIES = host-python-setuptools-scm
HOST_PYTHON_PLUGGY_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
$(eval $(host-python-package))
