################################################################################
#
# python-pluggy
#
################################################################################

PYTHON_PLUGGY_VERSION = 1.3.0
PYTHON_PLUGGY_SOURCE = pluggy-$(PYTHON_PLUGGY_VERSION).tar.gz
PYTHON_PLUGGY_SITE = https://files.pythonhosted.org/packages/36/51/04defc761583568cae5fd533abda3d40164cbdcf22dee5b7126ffef68a40
PYTHON_PLUGGY_SETUP_TYPE = setuptools
PYTHON_PLUGGY_LICENSE = MIT
PYTHON_PLUGGY_LICENSE_FILES = LICENSE
PYTHON_PLUGGY_DEPENDENCIES = host-python-setuptools-scm
HOST_PYTHON_PLUGGY_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
$(eval $(host-python-package))
