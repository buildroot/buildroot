################################################################################
#
# python-aniso8601
#
################################################################################

PYTHON_ANISO8601_VERSION = 10.0.1
PYTHON_ANISO8601_SOURCE = aniso8601-$(PYTHON_ANISO8601_VERSION).tar.gz
PYTHON_ANISO8601_SITE = https://files.pythonhosted.org/packages/8b/8d/52179c4e3f1978d3d9a285f98c706642522750ef343e9738286130423730
PYTHON_ANISO8601_SETUP_TYPE = setuptools
PYTHON_ANISO8601_LICENSE = BSD-3-Clause
PYTHON_ANISO8601_LICENSE_FILES = LICENSE

$(eval $(python-package))
