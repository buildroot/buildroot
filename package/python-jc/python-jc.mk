################################################################################
#
# python-jc
#
################################################################################

PYTHON_JC_VERSION = 1.25.7
PYTHON_JC_SOURCE = jc-$(PYTHON_JC_VERSION).tar.gz
PYTHON_JC_SITE = https://files.pythonhosted.org/packages/a9/da/7827d3389d87fa645556d595a2a437576de83f7a7d4a5fceda9c32208c0b
PYTHON_JC_SETUP_TYPE = setuptools
PYTHON_JC_LICENSE = MIT, BSD-3-Clause (bundled pbPlist)
PYTHON_JC_LICENSE_FILES = LICENSE.md

$(eval $(python-package))
