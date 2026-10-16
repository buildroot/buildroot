################################################################################
#
# python-snappy
#
################################################################################

PYTHON_SNAPPY_VERSION = 0.7.2
PYTHON_SNAPPY_SOURCE = python_snappy-$(PYTHON_SNAPPY_VERSION).tar.gz
PYTHON_SNAPPY_SITE = https://files.pythonhosted.org/packages/cb/52/acd87583175fa930e4385f8a6164eb5909acd683c0e62ee01d41de8195a2
PYTHON_SNAPPY_SETUP_TYPE = setuptools
PYTHON_SNAPPY_LICENSE = BSD-3-Clause
PYTHON_SNAPPY_LICENSE_FILES = LICENSE
PYTHON_SNAPPY_BUILD_OPTS = --skip-dependency-check

$(eval $(python-package))
