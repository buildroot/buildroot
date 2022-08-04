################################################################################
#
# python-dtschema
#
################################################################################

PYTHON_DTSCHEMA_VERSION = 2022.8
PYTHON_DTSCHEMA_SOURCE = dtschema-$(PYTHON_DTSCHEMA_VERSION).tar.gz
PYTHON_DTSCHEMA_SITE = https://files.pythonhosted.org/packages/95/be/cb576760b9578cb69da020aeb80f3c2d05ff46b4090ab350c1e05691329e
PYTHON_DTSCHEMA_SETUP_TYPE = setuptools
PYTHON_DTSCHEMA_LICENSE = BSD-2-Clause
PYTHON_DTSCHEMA_LICENSE_FILES = LICENSE.txt
PYTHON_DTSCHEMA_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
