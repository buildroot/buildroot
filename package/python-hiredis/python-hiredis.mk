################################################################################
#
# python-hiredis
#
################################################################################

PYTHON_HIREDIS_VERSION = 2.0.0
PYTHON_HIREDIS_SOURCE = hiredis-$(PYTHON_HIREDIS_VERSION).tar.gz
PYTHON_HIREDIS_SITE = https://files.pythonhosted.org/packages/0c/39/eae11344d69ba435ec13d6bcc1a9eea3d2278324506fcd0e52d1ed8958c8
PYTHON_HIREDIS_SETUP_TYPE = setuptools
PYTHON_HIREDIS_LICENSE = BSD-3-Clause
PYTHON_HIREDIS_LICENSE_FILES = COPYING vendor/hiredis/COPYING

$(eval $(python-package))
