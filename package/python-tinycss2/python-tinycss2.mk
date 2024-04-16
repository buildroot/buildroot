################################################################################
#
# python-tinycss2
#
################################################################################

PYTHON_TINYCSS2_VERSION = 1.2.1
PYTHON_TINYCSS2_SOURCE = tinycss2-$(PYTHON_TINYCSS2_VERSION).tar.gz
PYTHON_TINYCSS2_SITE = https://files.pythonhosted.org/packages/75/be/24179dfaa1d742c9365cbd0e3f0edc5d3aa3abad415a2327c5a6ff8ca077
PYTHON_TINYCSS2_SETUP_TYPE = flit
PYTHON_TINYCSS2_LICENSE = BSD-3-Clause
PYTHON_TINYCSS2_LICENSE_FILES = LICENSE

$(eval $(python-package))
