################################################################################
#
# python-jc
#
################################################################################

PYTHON_JC_VERSION = 1.25.2
PYTHON_JC_SOURCE = jc-$(PYTHON_JC_VERSION).tar.gz
PYTHON_JC_SITE = https://files.pythonhosted.org/packages/39/2e/c0d557b2ee673e2e0aef24a01e732aa232f6b1e180f339058f674f391ab8
PYTHON_JC_SETUP_TYPE = setuptools
PYTHON_JC_LICENSE = MIT, BSD-3-Clause (bundled pbPlist)
PYTHON_JC_LICENSE_FILES = LICENSE.md

$(eval $(python-package))
