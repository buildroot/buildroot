################################################################################
#
# python-pathspec
#
################################################################################

PYTHON_PATHSPEC_VERSION = 0.11.2
PYTHON_PATHSPEC_SOURCE = pathspec-$(PYTHON_PATHSPEC_VERSION).tar.gz
PYTHON_PATHSPEC_SITE = https://files.pythonhosted.org/packages/a0/2a/bd167cdf116d4f3539caaa4c332752aac0b3a0cc0174cdb302ee68933e81
PYTHON_PATHSPEC_LICENSE = MPL-2.0
PYTHON_PATHSPEC_LICENSE_FILES = LICENSE
PYTHON_PATHSPEC_SETUP_TYPE = setuptools

$(eval $(host-python-package))
