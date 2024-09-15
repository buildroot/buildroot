################################################################################
#
# python-hiredis
#
################################################################################

PYTHON_HIREDIS_VERSION = 3.0.0
PYTHON_HIREDIS_SOURCE = hiredis-$(PYTHON_HIREDIS_VERSION).tar.gz
PYTHON_HIREDIS_SITE = https://files.pythonhosted.org/packages/8b/80/740fb0dfa7a42416ce8376490f41dcdb1e5deed9c3739dfe4200fad865a9
PYTHON_HIREDIS_SETUP_TYPE = setuptools
PYTHON_HIREDIS_LICENSE = MIT, BSD-3-Clause
PYTHON_HIREDIS_LICENSE_FILES = LICENSE vendor/hiredis/COPYING

$(eval $(python-package))
