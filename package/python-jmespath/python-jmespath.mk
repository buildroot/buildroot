################################################################################
#
# python-jmespath
#
################################################################################

PYTHON_JMESPATH_VERSION = 1.1.0
PYTHON_JMESPATH_SOURCE = jmespath-$(PYTHON_JMESPATH_VERSION).tar.gz
PYTHON_JMESPATH_SITE = https://files.pythonhosted.org/packages/d3/59/322338183ecda247fb5d1763a6cbe46eff7222eaeebafd9fa65d4bf5cb11
PYTHON_JMESPATH_SETUP_TYPE = setuptools
PYTHON_JMESPATH_LICENSE = MIT
PYTHON_JMESPATH_LICENSE_FILES = LICENSE

$(eval $(python-package))
