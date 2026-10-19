################################################################################
#
# python-jc
#
################################################################################

PYTHON_JC_VERSION = 1.26.1
PYTHON_JC_SOURCE = jc-$(PYTHON_JC_VERSION).tar.gz
PYTHON_JC_SITE = https://files.pythonhosted.org/packages/e8/e0/ac16e68e8e56d0c63eb97d6d9a0f1d0320dcd16763ab288de4ea950eb7ca
PYTHON_JC_SETUP_TYPE = setuptools
PYTHON_JC_LICENSE = MIT, BSD-3-Clause (bundled pbPlist)
PYTHON_JC_LICENSE_FILES = LICENSE.md

$(eval $(python-package))
