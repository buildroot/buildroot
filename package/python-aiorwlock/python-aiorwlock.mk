################################################################################
#
# python-aiorwlock
#
################################################################################

PYTHON_AIORWLOCK_VERSION = 1.3.0
PYTHON_AIORWLOCK_SOURCE = aiorwlock-$(PYTHON_AIORWLOCK_VERSION).tar.gz
PYTHON_AIORWLOCK_SITE = https://files.pythonhosted.org/packages/77/fe/7027595f5e635ac1f597f7160a420e1f642a474576efb697001efea16bdc
PYTHON_AIORWLOCK_SETUP_TYPE = setuptools
PYTHON_AIORWLOCK_LICENSE = Apache-2.0
PYTHON_AIORWLOCK_LICENSE_FILES = LICENSE

$(eval $(python-package))
