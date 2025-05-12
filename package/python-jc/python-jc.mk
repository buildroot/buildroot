################################################################################
#
# python-jc
#
################################################################################

PYTHON_JC_VERSION = 1.25.5
PYTHON_JC_SOURCE = jc-$(PYTHON_JC_VERSION).tar.gz
PYTHON_JC_SITE = https://files.pythonhosted.org/packages/1b/da/f6ec6a79f8dea70671f41d7162cfefdfe97e9c5b6c2227c1737183c05cd6
PYTHON_JC_SETUP_TYPE = setuptools
PYTHON_JC_LICENSE = MIT, BSD-3-Clause (bundled pbPlist)
PYTHON_JC_LICENSE_FILES = LICENSE.md

$(eval $(python-package))
