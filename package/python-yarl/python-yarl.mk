################################################################################
#
# python-yarl
#
################################################################################

PYTHON_YARL_VERSION = 1.17.1
PYTHON_YARL_SOURCE = yarl-$(PYTHON_YARL_VERSION).tar.gz
PYTHON_YARL_SITE = https://files.pythonhosted.org/packages/54/9c/9c0a9bfa683fc1be7fdcd9687635151544d992cccd48892dc5e0a5885a29
PYTHON_YARL_LICENSE = Apache-2.0
PYTHON_YARL_LICENSE_FILES = LICENSE
PYTHON_YARL_SETUP_TYPE = setuptools
PYTHON_YARL_DEPENDENCIES = \
	host-python-cython \
	host-python-expandvars

$(eval $(python-package))
