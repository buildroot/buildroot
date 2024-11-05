################################################################################
#
# python-typeguard
#
################################################################################

PYTHON_TYPEGUARD_VERSION = 4.4.1
PYTHON_TYPEGUARD_SOURCE = typeguard-$(PYTHON_TYPEGUARD_VERSION).tar.gz
PYTHON_TYPEGUARD_SITE = https://files.pythonhosted.org/packages/62/c3/400917dd37d7b8c07e9723f3046818530423e1e759a56a22133362adab00
PYTHON_TYPEGUARD_SETUP_TYPE = setuptools
PYTHON_TYPEGUARD_LICENSE = MIT
PYTHON_TYPEGUARD_LICENSE_FILES = LICENSE
PYTHON_TYPEGUARD_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
