################################################################################
#
# python-trio
#
################################################################################

PYTHON_TRIO_VERSION = 0.34.0
PYTHON_TRIO_SOURCE = trio-$(PYTHON_TRIO_VERSION).tar.gz
PYTHON_TRIO_SITE = https://files.pythonhosted.org/packages/92/dc/a2d25ed73ad49cfd79bf18d262577c3731c98e382284e28d522f49a0df35
PYTHON_TRIO_SETUP_TYPE = setuptools
PYTHON_TRIO_LICENSE = Apache-2.0 or MIT
PYTHON_TRIO_LICENSE_FILES = LICENSE LICENSE.APACHE2 LICENSE.MIT

$(eval $(python-package))
