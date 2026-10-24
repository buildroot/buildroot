################################################################################
#
# python-wcwidth
#
################################################################################

PYTHON_WCWIDTH_VERSION = 0.9.4
PYTHON_WCWIDTH_SOURCE = wcwidth-$(PYTHON_WCWIDTH_VERSION).tar.gz
PYTHON_WCWIDTH_SITE = https://files.pythonhosted.org/packages/ea/01/e5ac23733628a6bbb91913a765fcf55ee8070d8d991bc88fdaaf805052c7
PYTHON_WCWIDTH_SETUP_TYPE = setuptools
PYTHON_WCWIDTH_LICENSE = MIT
PYTHON_WCWIDTH_LICENSE_FILES = LICENSE

$(eval $(python-package))
