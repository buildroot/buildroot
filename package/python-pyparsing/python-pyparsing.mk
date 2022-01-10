################################################################################
#
# python-pyparsing
#
################################################################################

PYTHON_PYPARSING_VERSION = 3.0.6
PYTHON_PYPARSING_SOURCE = pyparsing-$(PYTHON_PYPARSING_VERSION).tar.gz
PYTHON_PYPARSING_SITE = https://files.pythonhosted.org/packages/ab/61/1a1613e3dcca483a7aa9d446cb4614e6425eb853b90db131c305bd9674cb
PYTHON_PYPARSING_LICENSE = MIT
PYTHON_PYPARSING_LICENSE_FILES = LICENSE
PYTHON_PYPARSING_SETUP_TYPE = setuptools
HOST_PYTHON_PYPARSING_NEEDS_HOST_PYTHON = python3

$(eval $(python-package))
$(eval $(host-python-package))
