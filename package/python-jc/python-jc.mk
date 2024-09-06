################################################################################
#
# python-jc
#
################################################################################

PYTHON_JC_VERSION = 1.25.3
PYTHON_JC_SOURCE = jc-$(PYTHON_JC_VERSION).tar.gz
PYTHON_JC_SITE = https://files.pythonhosted.org/packages/a5/82/bfb1ec7d9667bc2f922254bc62e12fd460a5de3b711518f5089df0a17180
PYTHON_JC_SETUP_TYPE = setuptools
PYTHON_JC_LICENSE = MIT, BSD-3-Clause (bundled pbPlist)
PYTHON_JC_LICENSE_FILES = LICENSE.md

$(eval $(python-package))
