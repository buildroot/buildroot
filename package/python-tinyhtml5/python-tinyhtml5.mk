################################################################################
#
# python-tinyhtml5
#
################################################################################

PYTHON_TINYHTML5_VERSION = 2.0.0
PYTHON_TINYHTML5_SOURCE = tinyhtml5-$(PYTHON_TINYHTML5_VERSION).tar.gz
PYTHON_TINYHTML5_SITE = https://files.pythonhosted.org/packages/fd/03/6111ed99e9bf7dfa1c30baeef0e0fb7e0bd387bd07f8e5b270776fe1de3f
PYTHON_TINYHTML5_SETUP_TYPE = flit
PYTHON_TINYHTML5_LICENSE = MIT
PYTHON_TINYHTML5_LICENSE_FILES = LICENSE

$(eval $(python-package))
