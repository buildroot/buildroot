################################################################################
#
# python-snappy
#
################################################################################

PYTHON_SNAPPY_VERSION = 0.6.1
PYTHON_SNAPPY_SITE = https://files.pythonhosted.org/packages/98/7a/44a24bad98335b2c72e4cadcdecf79f50197d1bab9f22f863a274f104b96
PYTHON_SNAPPY_SETUP_TYPE = setuptools
PYTHON_SNAPPY_LICENSE = BSD-3-Clause
PYTHON_SNAPPY_LICENSE_FILES = LICENSE
PYTHON_SNAPPY_DEPENDENCIES = snappy

$(eval $(python-package))
