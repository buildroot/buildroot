################################################################################
#
# python-hiredis
#
################################################################################

PYTHON_HIREDIS_VERSION = 3.1.0
PYTHON_HIREDIS_SOURCE = hiredis-$(PYTHON_HIREDIS_VERSION).tar.gz
PYTHON_HIREDIS_SITE = https://files.pythonhosted.org/packages/38/e5/789cfa8993ced0061a6ef7ea758302ef5cf3439629bf0d39c85a6ede4641
PYTHON_HIREDIS_SETUP_TYPE = setuptools
PYTHON_HIREDIS_LICENSE = MIT, BSD-3-Clause
PYTHON_HIREDIS_LICENSE_FILES = LICENSE vendor/hiredis/COPYING

$(eval $(python-package))
