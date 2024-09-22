################################################################################
#
# python-wcwidth
#
################################################################################

PYTHON_WCWIDTH_VERSION = 0.2.13
PYTHON_WCWIDTH_SOURCE = wcwidth-$(PYTHON_WCWIDTH_VERSION).tar.gz
PYTHON_WCWIDTH_SITE = https://files.pythonhosted.org/packages/6c/63/53559446a878410fc5a5974feb13d31d78d752eb18aeba59c7fef1af7598
PYTHON_WCWIDTH_SETUP_TYPE = setuptools
PYTHON_WCWIDTH_LICENSE = MIT
PYTHON_WCWIDTH_LICENSE_FILES = LICENSE

$(eval $(python-package))
