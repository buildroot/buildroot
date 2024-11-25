################################################################################
#
# python-aiorwlock
#
################################################################################

PYTHON_AIORWLOCK_VERSION = 1.4.0
PYTHON_AIORWLOCK_SOURCE = aiorwlock-$(PYTHON_AIORWLOCK_VERSION).tar.gz
PYTHON_AIORWLOCK_SITE = https://files.pythonhosted.org/packages/ba/c5/882b4c89d71d6f9c7d0d8dee18d267025e71d4c3241eb3b16ab39105a0d1
PYTHON_AIORWLOCK_SETUP_TYPE = setuptools
PYTHON_AIORWLOCK_LICENSE = Apache-2.0
PYTHON_AIORWLOCK_LICENSE_FILES = LICENSE

$(eval $(python-package))
