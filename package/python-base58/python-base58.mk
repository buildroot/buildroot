################################################################################
#
# python-base58
#
################################################################################

PYTHON_BASE58_VERSION = 2.1.1
PYTHON_BASE58_SOURCE = base58-$(PYTHON_BASE58_VERSION).tar.gz
PYTHON_BASE58_SITE = https://files.pythonhosted.org/packages/7f/45/8ae61209bb9015f516102fa559a2914178da1d5868428bd86a1b4421141d
PYTHON_BASE58_SETUP_TYPE = setuptools
PYTHON_BASE58_LICENSE = MIT
PYTHON_BASE58_LICENSE_FILES = COPYING

$(eval $(python-package))
