################################################################################
#
# python-automat
#
################################################################################

PYTHON_AUTOMAT_VERSION = 25.4.16
PYTHON_AUTOMAT_SOURCE = automat-$(PYTHON_AUTOMAT_VERSION).tar.gz
PYTHON_AUTOMAT_SITE = https://files.pythonhosted.org/packages/e3/0f/d40bbe294bbf004d436a8bcbcfaadca8b5140d39ad0ad3d73d1a8ba15f14
PYTHON_AUTOMAT_SETUP_TYPE = hatch
PYTHON_AUTOMAT_LICENSE = MIT
PYTHON_AUTOMAT_LICENSE_FILES = LICENSE
PYTHON_AUTOMAT_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
