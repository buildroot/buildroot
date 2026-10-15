################################################################################
#
# python-hiredis
#
################################################################################

PYTHON_HIREDIS_VERSION = 3.5.0
PYTHON_HIREDIS_SOURCE = hiredis-$(PYTHON_HIREDIS_VERSION).tar.gz
PYTHON_HIREDIS_SITE = https://files.pythonhosted.org/packages/b4/72/64065841e93c3b8b507d7889d7de371e5f397b5efd60f18c2d82d5bd3636
PYTHON_HIREDIS_SETUP_TYPE = setuptools
PYTHON_HIREDIS_LICENSE = MIT, BSD-3-Clause
PYTHON_HIREDIS_LICENSE_FILES = LICENSE vendor/hiredis/COPYING

$(eval $(python-package))
