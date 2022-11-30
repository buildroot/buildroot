################################################################################
#
# python-aenum
#
################################################################################

PYTHON_AENUM_VERSION = 3.1.11
PYTHON_AENUM_SOURCE = aenum-$(PYTHON_AENUM_VERSION).tar.gz
PYTHON_AENUM_SITE = https://files.pythonhosted.org/packages/63/6c/a71e18de7c651f384b328be6bccadbbd472aca62f547c1a307b9388d03ca
PYTHON_AENUM_SETUP_TYPE = setuptools
PYTHON_AENUM_LICENSE = BSD-3-Clause
PYTHON_AENUM_LICENSE_FILES = aenum/LICENSE

# _py2.py uses syntax not compatible with Python3.
# Remove _py2.py to avoid compilation error.
define PYTHON_AENUM_REMOVE_PY2_PY
	rm $(@D)/aenum/_py2.py
endef

PYTHON_AENUM_POST_EXTRACT_HOOKS = PYTHON_AENUM_REMOVE_PY2_PY

$(eval $(python-package))
