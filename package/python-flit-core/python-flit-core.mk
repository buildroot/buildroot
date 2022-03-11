################################################################################
#
# python-flit-core
#
################################################################################

PYTHON_FLIT_CORE_VERSION = 3.7.1
PYTHON_FLIT_CORE_SOURCE = flit_core-$(PYTHON_FLIT_CORE_VERSION).tar.gz
PYTHON_FLIT_CORE_SITE = https://files.pythonhosted.org/packages/15/d1/d8798b83e953fd6f86ca9b50f93eec464a9305b0661469c8234e61095481
PYTHON_FLIT_CORE_LICENSE = BSD-3-Clause
PYTHON_FLIT_CORE_SETUP_TYPE = pep517

$(eval $(host-python-package))
