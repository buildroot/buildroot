################################################################################
#
# python-dtschema
#
################################################################################

PYTHON_DTSCHEMA_VERSION = 2024.9
PYTHON_DTSCHEMA_SOURCE = dtschema-$(PYTHON_DTSCHEMA_VERSION).tar.gz
PYTHON_DTSCHEMA_SITE = https://files.pythonhosted.org/packages/6e/ed/38406756269a83b341ceb5884874692f18eeae820b70a198e8f3699c11da
PYTHON_DTSCHEMA_SETUP_TYPE = setuptools
PYTHON_DTSCHEMA_LICENSE = BSD-2-Clause
PYTHON_DTSCHEMA_LICENSE_FILES = LICENSE.txt
PYTHON_DTSCHEMA_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
