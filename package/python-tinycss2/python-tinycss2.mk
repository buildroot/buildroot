################################################################################
#
# python-tinycss2
#
################################################################################

PYTHON_TINYCSS2_VERSION = 1.1.1
PYTHON_TINYCSS2_SOURCE = tinycss2-$(PYTHON_TINYCSS2_VERSION).tar.gz
PYTHON_TINYCSS2_SITE = https://files.pythonhosted.org/packages/1e/5a/576828164b5486f319c4323915b915a8af3fa4a654bbb6f8fc8e87b5cb17
PYTHON_TINYCSS2_SETUP_TYPE = flit
PYTHON_TINYCSS2_LICENSE = BSD-3-Clause
PYTHON_TINYCSS2_LICENSE_FILES = LICENSE

$(eval $(python-package))
