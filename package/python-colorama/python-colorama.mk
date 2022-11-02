################################################################################
#
# python-colorama
#
################################################################################

PYTHON_COLORAMA_VERSION = 0.4.6
PYTHON_COLORAMA_SOURCE = colorama-$(PYTHON_COLORAMA_VERSION).tar.gz
PYTHON_COLORAMA_SITE = https://files.pythonhosted.org/packages/d8/53/6f443c9a4a8358a93a6792e2acffb9d9d5cb0a5cfd8802644b7b1c9a02e4
PYTHON_COLORAMA_SETUP_TYPE = pep517
PYTHON_COLORAMA_LICENSE = BSD-3-Clause
PYTHON_COLORAMA_LICENSE_FILES = LICENSE.txt
PYTHON_COLORAMA_DEPENDENCIES = host-python-hatchling

$(eval $(python-package))
