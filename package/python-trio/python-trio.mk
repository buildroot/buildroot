################################################################################
#
# python-trio
#
################################################################################

PYTHON_TRIO_VERSION = 0.26.2
PYTHON_TRIO_SOURCE = trio-$(PYTHON_TRIO_VERSION).tar.gz
PYTHON_TRIO_SITE = https://files.pythonhosted.org/packages/9a/03/ab0e9509be0c6465e2773768ec25ee0cb8053c0b91471ab3854bbf2294b2
PYTHON_TRIO_SETUP_TYPE = setuptools
PYTHON_TRIO_LICENSE = Apache-2.0 or MIT
PYTHON_TRIO_LICENSE_FILES = LICENSE LICENSE.APACHE2 LICENSE.MIT

$(eval $(python-package))
