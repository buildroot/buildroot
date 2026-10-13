################################################################################
#
# python-wcwidth
#
################################################################################

PYTHON_WCWIDTH_VERSION = 0.9.2
PYTHON_WCWIDTH_SOURCE = wcwidth-$(PYTHON_WCWIDTH_VERSION).tar.gz
PYTHON_WCWIDTH_SITE = https://files.pythonhosted.org/packages/f0/b4/7830542634bb2d3e62aa3b586a72d5b3b6c91c3168929e7000ef3fed041d
PYTHON_WCWIDTH_SETUP_TYPE = setuptools
PYTHON_WCWIDTH_LICENSE = MIT
PYTHON_WCWIDTH_LICENSE_FILES = LICENSE

$(eval $(python-package))
