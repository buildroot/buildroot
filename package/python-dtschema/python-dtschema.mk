################################################################################
#
# python-dtschema
#
################################################################################

PYTHON_DTSCHEMA_VERSION = 2024.11
PYTHON_DTSCHEMA_SOURCE = dtschema-$(PYTHON_DTSCHEMA_VERSION).tar.gz
PYTHON_DTSCHEMA_SITE = https://files.pythonhosted.org/packages/b7/e2/260c0429118b1555ddc2d0d465b7ab36e76ab2454a3d1a916ef06dffccca
PYTHON_DTSCHEMA_SETUP_TYPE = setuptools
PYTHON_DTSCHEMA_LICENSE = BSD-2-Clause
PYTHON_DTSCHEMA_LICENSE_FILES = LICENSE.txt
PYTHON_DTSCHEMA_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
