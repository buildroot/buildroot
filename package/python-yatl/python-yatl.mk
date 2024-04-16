################################################################################
#
# python-yatl
#
################################################################################

PYTHON_YATL_VERSION = 20220907.1
PYTHON_YATL_SOURCE = yatl-$(PYTHON_YATL_VERSION).tar.gz
PYTHON_YATL_SITE = https://files.pythonhosted.org/packages/09/68/0c9d0a1192fdad5f3d38db096106c5adabb9b26c9ae107897997f56d1788
PYTHON_YATL_SETUP_TYPE = setuptools
PYTHON_YATL_LICENSE = BSD-3-Clause

$(eval $(python-package))
$(eval $(host-python-package))
