################################################################################
#
# python-jc
#
################################################################################

PYTHON_JC_VERSION = 1.25.1
PYTHON_JC_SOURCE = jc-$(PYTHON_JC_VERSION).tar.gz
PYTHON_JC_SITE = https://files.pythonhosted.org/packages/53/a6/065f0796a0a21bc040bc88c8a33410c12729a2a6f4c269d0349f685796da
PYTHON_JC_SETUP_TYPE = setuptools
PYTHON_JC_LICENSE = MIT, BSD-3-Clause (bundled pbPlist)
PYTHON_JC_LICENSE_FILES = LICENSE.md

$(eval $(python-package))
