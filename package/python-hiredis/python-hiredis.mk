################################################################################
#
# python-hiredis
#
################################################################################

PYTHON_HIREDIS_VERSION = 2.2.3
PYTHON_HIREDIS_SOURCE = hiredis-$(PYTHON_HIREDIS_VERSION).tar.gz
PYTHON_HIREDIS_SITE = https://files.pythonhosted.org/packages/b0/04/dab6792584fc548803ffa50b5bb2b99f01d3ab04d7c7f64e85f1a22fb847
PYTHON_HIREDIS_SETUP_TYPE = setuptools
PYTHON_HIREDIS_LICENSE = BSD-3-Clause
PYTHON_HIREDIS_LICENSE_FILES = LICENSE vendor/hiredis/COPYING

$(eval $(python-package))
