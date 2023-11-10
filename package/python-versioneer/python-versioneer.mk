################################################################################
#
# python-versioneer
#
################################################################################

PYTHON_VERSIONEER_VERSION = 0.29
PYTHON_VERSIONEER_SOURCE = versioneer-$(PYTHON_VERSIONEER_VERSION).tar.gz
PYTHON_VERSIONEER_SITE = https://files.pythonhosted.org/packages/32/d7/854e45d2b03e1a8ee2aa6429dd396d002ce71e5d88b77551b2fb249cb382
PYTHON_VERSIONEER_SETUP_TYPE = setuptools
PYTHON_VERSIONEER_LICENSE = Unlicense
PYTHON_VERSIONEER_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
