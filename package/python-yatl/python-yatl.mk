################################################################################
#
# python-yatl
#
################################################################################

PYTHON_YATL_VERSION = 20211217.1
PYTHON_YATL_SOURCE = yatl-$(PYTHON_YATL_VERSION).tar.gz
PYTHON_YATL_SITE = https://files.pythonhosted.org/packages/03/05/0be8164e8151fd8c96caeb2560f955dc2dc1a969f0868f48c046cd863fe6
PYTHON_YATL_SETUP_TYPE = setuptools
PYTHON_YATL_LICENSE = BSD-3-Clause

$(eval $(python-package))
$(eval $(host-python-package))
