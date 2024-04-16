################################################################################
#
# python-aenum
#
################################################################################

PYTHON_AENUM_VERSION = 3.1.15
PYTHON_AENUM_SOURCE = aenum-$(PYTHON_AENUM_VERSION).tar.gz
PYTHON_AENUM_SITE = https://files.pythonhosted.org/packages/d0/f8/33e75863394f42e429bb553e05fda7c59763f0fd6848de847a25b3fbccf6
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
