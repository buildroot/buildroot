################################################################################
#
# python-tinycss2
#
################################################################################

PYTHON_TINYCSS2_VERSION = 1.4.0
PYTHON_TINYCSS2_SOURCE = tinycss2-$(PYTHON_TINYCSS2_VERSION).tar.gz
PYTHON_TINYCSS2_SITE = https://files.pythonhosted.org/packages/7a/fd/7a5ee21fd08ff70d3d33a5781c255cbe779659bd03278feb98b19ee550f4
PYTHON_TINYCSS2_SETUP_TYPE = flit
PYTHON_TINYCSS2_LICENSE = BSD-3-Clause
PYTHON_TINYCSS2_LICENSE_FILES = LICENSE

$(eval $(python-package))
