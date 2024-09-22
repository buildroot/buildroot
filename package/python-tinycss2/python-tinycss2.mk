################################################################################
#
# python-tinycss2
#
################################################################################

PYTHON_TINYCSS2_VERSION = 1.3.0
PYTHON_TINYCSS2_SOURCE = tinycss2-$(PYTHON_TINYCSS2_VERSION).tar.gz
PYTHON_TINYCSS2_SITE = https://files.pythonhosted.org/packages/44/6f/38d2335a2b70b9982d112bb177e3dbe169746423e33f718bf5e9c7b3ddd3
PYTHON_TINYCSS2_SETUP_TYPE = flit
PYTHON_TINYCSS2_LICENSE = BSD-3-Clause
PYTHON_TINYCSS2_LICENSE_FILES = LICENSE

$(eval $(python-package))
