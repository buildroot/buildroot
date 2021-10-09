################################################################################
#
# python-crossbar
#
################################################################################

PYTHON_CROSSBAR_VERSION = 21.3.1
PYTHON_CROSSBAR_SOURCE = crossbar-$(PYTHON_CROSSBAR_VERSION).tar.gz
PYTHON_CROSSBAR_SITE = https://files.pythonhosted.org/packages/17/37/aafc4ec30068fd7ebb97f1a00d4ddf8de482dfa4c1d2a1fc6bb814d91400
PYTHON_CROSSBAR_LICENSE = AGPL-3.0
PYTHON_CROSSBAR_LICENSE_FILES = crossbar/LICENSE
PYTHON_CROSSBAR_SETUP_TYPE = setuptools

$(eval $(python-package))
