################################################################################
#
# python-typeguard
#
################################################################################

PYTHON_TYPEGUARD_VERSION = 4.5.1
PYTHON_TYPEGUARD_SOURCE = typeguard-$(PYTHON_TYPEGUARD_VERSION).tar.gz
PYTHON_TYPEGUARD_SITE = https://files.pythonhosted.org/packages/2b/e8/66e25efcc18542d58706ce4e50415710593721aae26e794ab1dec34fb66f
PYTHON_TYPEGUARD_SETUP_TYPE = setuptools
PYTHON_TYPEGUARD_LICENSE = MIT
PYTHON_TYPEGUARD_LICENSE_FILES = LICENSE
PYTHON_TYPEGUARD_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
