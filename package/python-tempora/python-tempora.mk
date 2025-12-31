################################################################################
#
# python-tempora
#
################################################################################

PYTHON_TEMPORA_VERSION = 5.8.1
PYTHON_TEMPORA_SOURCE = tempora-$(PYTHON_TEMPORA_VERSION).tar.gz
PYTHON_TEMPORA_SITE = https://files.pythonhosted.org/packages/24/64/a255efe5edd367d12b770b3514194efdc1c97e5ed6ce6e8105d834750dfc
PYTHON_TEMPORA_LICENSE = MIT
PYTHON_TEMPORA_LICENSE_FILES = LICENSE
PYTHON_TEMPORA_SETUP_TYPE = setuptools
PYTHON_TEMPORA_DEPENDENCIES = \
	host-python-coherent-licensed \
	host-python-setuptools-scm

$(eval $(python-package))
