################################################################################
#
# python-jc
#
################################################################################

PYTHON_JC_VERSION = 1.26.2
PYTHON_JC_SOURCE = jc-$(PYTHON_JC_VERSION).tar.gz
PYTHON_JC_SITE = https://files.pythonhosted.org/packages/d6/6b/001e082ba68c5ba0a604a6664afb66a1302539da0fdb7862f5d7a9ff0902
PYTHON_JC_SETUP_TYPE = setuptools
PYTHON_JC_LICENSE = MIT, BSD-3-Clause (bundled pbPlist)
PYTHON_JC_LICENSE_FILES = LICENSE.md

$(eval $(python-package))
