################################################################################
#
# python-tinycss2
#
################################################################################

PYTHON_TINYCSS2_VERSION = 1.1.0
PYTHON_TINYCSS2_SOURCE = tinycss2-$(PYTHON_TINYCSS2_VERSION).tar.gz
PYTHON_TINYCSS2_SITE = https://files.pythonhosted.org/packages/ce/d3/ece7a98d5826bd134e269a3a3030153d30482194fca71d95a3041812aab8
PYTHON_TINYCSS2_SETUP_TYPE = distutils
PYTHON_TINYCSS2_LICENSE = BSD-3-Clause
PYTHON_TINYCSS2_LICENSE_FILES = LICENSE

$(eval $(python-package))
