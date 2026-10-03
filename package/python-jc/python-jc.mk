################################################################################
#
# python-jc
#
################################################################################

PYTHON_JC_VERSION = 1.26.0
PYTHON_JC_SOURCE = jc-$(PYTHON_JC_VERSION).tar.gz
PYTHON_JC_SITE = https://files.pythonhosted.org/packages/95/5f/9e6e8dc65cb15662fcfc090a52ed4fc4334ab7703b42107bc992777d19a1
PYTHON_JC_SETUP_TYPE = setuptools
PYTHON_JC_LICENSE = MIT, BSD-3-Clause (bundled pbPlist)
PYTHON_JC_LICENSE_FILES = LICENSE.md

$(eval $(python-package))
