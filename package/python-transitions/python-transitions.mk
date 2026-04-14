################################################################################
#
# python-transitions
#
################################################################################

PYTHON_TRANSITIONS_VERSION = 0.9.3
PYTHON_TRANSITIONS_SOURCE = transitions-$(PYTHON_TRANSITIONS_VERSION).tar.gz
PYTHON_TRANSITIONS_SITE = https://files.pythonhosted.org/packages/source/t/transitions
PYTHON_TRANSITIONS_SETUP_TYPE = setuptools

PYTHON_TRANSITIONS_LICENSE = MIT
PYTHON_TRANSITIONS_LICENSE_FILES = LICENSE

$(eval $(python-package))
