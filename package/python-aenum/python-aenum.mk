################################################################################
#
# python-aenum
#
################################################################################

PYTHON_AENUM_VERSION = 3.1.0
PYTHON_AENUM_SOURCE = aenum-$(PYTHON_AENUM_VERSION).tar.gz
PYTHON_AENUM_SITE = https://files.pythonhosted.org/packages/ae/25/00b2949186e76a4c9732e33221274964fecf5c88178cbe5a14a80cfc04e8
PYTHON_AENUM_SETUP_TYPE = setuptools
PYTHON_AENUM_LICENSE = BSD-3-Clause
PYTHON_AENUM_LICENSE_FILES = aenum/LICENSE

$(eval $(python-package))
