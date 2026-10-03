################################################################################
#
# python-pydal
#
################################################################################

PYTHON_PYDAL_VERSION = 20260520.0
PYTHON_PYDAL_SOURCE = pydal-$(PYTHON_PYDAL_VERSION).tar.gz
PYTHON_PYDAL_SITE = https://files.pythonhosted.org/packages/20/4e/1d576fcb6857f56cd0aeb413c387044fd609140628d1c401b7ae29ee6190
PYTHON_PYDAL_LICENSE = BSD-3-Clause
PYTHON_PYDAL_LICENSE_FILES = LICENSE.txt
PYTHON_PYDAL_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
