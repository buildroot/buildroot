################################################################################
#
# python-wrapt
#
################################################################################

PYTHON_WRAPT_VERSION = 2.5.2
PYTHON_WRAPT_SOURCE = wrapt-$(PYTHON_WRAPT_VERSION).tar.gz
PYTHON_WRAPT_SITE = https://files.pythonhosted.org/packages/9c/b0/f752d19e1e83ab8bd64aeccfde32ff086aee3ef08520f7340b69a8d0a4d2
PYTHON_WRAPT_SETUP_TYPE = setuptools
PYTHON_WRAPT_LICENSE = BSD-2-Clause
PYTHON_WRAPT_LICENSE_FILES = LICENSE

$(eval $(python-package))
