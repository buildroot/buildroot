################################################################################
#
# python-jc
#
################################################################################

PYTHON_JC_VERSION = 1.25.4
PYTHON_JC_SOURCE = jc-$(PYTHON_JC_VERSION).tar.gz
PYTHON_JC_SITE = https://files.pythonhosted.org/packages/5b/82/146ef4c94297ef87c6a732c92dd57761bea2c2179e1b8ca8a6b9b8dd6ff7
PYTHON_JC_SETUP_TYPE = setuptools
PYTHON_JC_LICENSE = MIT, BSD-3-Clause (bundled pbPlist)
PYTHON_JC_LICENSE_FILES = LICENSE.md

$(eval $(python-package))
