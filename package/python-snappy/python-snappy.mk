################################################################################
#
# python-snappy
#
################################################################################

PYTHON_SNAPPY_VERSION = 0.7.3
PYTHON_SNAPPY_SOURCE = python_snappy-$(PYTHON_SNAPPY_VERSION).tar.gz
PYTHON_SNAPPY_SITE = https://files.pythonhosted.org/packages/39/66/9185fbb6605ba92716d9f77fbb13c97eb671cd13c3ad56bd154016fbf08b
PYTHON_SNAPPY_SETUP_TYPE = setuptools
PYTHON_SNAPPY_LICENSE = BSD-3-Clause
PYTHON_SNAPPY_LICENSE_FILES = LICENSE
PYTHON_SNAPPY_BUILD_OPTS = --skip-dependency-check

$(eval $(python-package))
