################################################################################
#
# python-yatl
#
################################################################################

PYTHON_YATL_VERSION = 20230507.3
PYTHON_YATL_SOURCE = yatl-$(PYTHON_YATL_VERSION).tar.gz
PYTHON_YATL_SITE = https://files.pythonhosted.org/packages/bd/3b/723a667a24512a299e1e139608e787c3b24b7819302c15c7aac09c3bec68
PYTHON_YATL_SETUP_TYPE = setuptools
PYTHON_YATL_LICENSE = BSD-3-Clause
PYTHON_YATL_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
$(eval $(host-python-package))
