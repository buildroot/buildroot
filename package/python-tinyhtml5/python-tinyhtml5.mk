################################################################################
#
# python-tinyhtml5
#
################################################################################

PYTHON_TINYHTML5_VERSION = 2.1.0
PYTHON_TINYHTML5_SOURCE = tinyhtml5-$(PYTHON_TINYHTML5_VERSION).tar.gz
PYTHON_TINYHTML5_SITE = https://files.pythonhosted.org/packages/b1/1f/cfe2f6b30557c92b3f31d41707e09cef5c1efbd87392bc6c0430c46b0e4d
PYTHON_TINYHTML5_SETUP_TYPE = flit
PYTHON_TINYHTML5_LICENSE = MIT
PYTHON_TINYHTML5_LICENSE_FILES = LICENSE

$(eval $(python-package))
