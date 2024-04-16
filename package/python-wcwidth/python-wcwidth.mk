################################################################################
#
# python-wcwidth
#
################################################################################

PYTHON_WCWIDTH_VERSION = 0.2.5
PYTHON_WCWIDTH_SOURCE = wcwidth-$(PYTHON_WCWIDTH_VERSION).tar.gz
PYTHON_WCWIDTH_SITE = https://files.pythonhosted.org/packages/89/38/459b727c381504f361832b9e5ace19966de1a235d73cdbdea91c771a1155
PYTHON_WCWIDTH_SETUP_TYPE = setuptools
PYTHON_WCWIDTH_LICENSE = MIT
PYTHON_WCWIDTH_LICENSE_FILES = LICENSE

$(eval $(python-package))
