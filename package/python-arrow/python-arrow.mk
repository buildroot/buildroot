################################################################################
#
# python-arrow
#
################################################################################

PYTHON_ARROW_VERSION = 1.4.0
PYTHON_ARROW_SOURCE = arrow-$(PYTHON_ARROW_VERSION).tar.gz
PYTHON_ARROW_SITE = https://files.pythonhosted.org/packages/b9/33/032cdc44182491aa708d06a68b62434140d8c50820a087fac7af37703357
PYTHON_ARROW_SETUP_TYPE = flit
PYTHON_ARROW_LICENSE = Apache-2.0
PYTHON_ARROW_LICENSE_FILES = LICENSE

$(eval $(python-package))
