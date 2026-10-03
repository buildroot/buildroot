################################################################################
#
# python-hiredis
#
################################################################################

PYTHON_HIREDIS_VERSION = 3.4.2
PYTHON_HIREDIS_SOURCE = hiredis-$(PYTHON_HIREDIS_VERSION).tar.gz
PYTHON_HIREDIS_SITE = https://files.pythonhosted.org/packages/38/da/41b341ebed1eb6f1074112936af98bb52880724737887ae9bade9d7ce107
PYTHON_HIREDIS_SETUP_TYPE = setuptools
PYTHON_HIREDIS_LICENSE = MIT, BSD-3-Clause
PYTHON_HIREDIS_LICENSE_FILES = LICENSE vendor/hiredis/COPYING

$(eval $(python-package))
