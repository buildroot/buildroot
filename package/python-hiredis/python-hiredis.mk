################################################################################
#
# python-hiredis
#
################################################################################

PYTHON_HIREDIS_VERSION = 2.3.2
PYTHON_HIREDIS_SOURCE = hiredis-$(PYTHON_HIREDIS_VERSION).tar.gz
PYTHON_HIREDIS_SITE = https://files.pythonhosted.org/packages/fe/2d/a5ae61da1157644f7e52e088fa158ac6f5d09775112d14b1c9b9a5156bf1
PYTHON_HIREDIS_SETUP_TYPE = setuptools
PYTHON_HIREDIS_LICENSE = MIT, BSD-3-Clause
PYTHON_HIREDIS_LICENSE_FILES = LICENSE vendor/hiredis/COPYING

$(eval $(python-package))
