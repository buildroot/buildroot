################################################################################
#
# python-pydyf
#
################################################################################

PYTHON_PYDYF_VERSION = 0.8.0
PYTHON_PYDYF_SOURCE = pydyf-$(PYTHON_PYDYF_VERSION).tar.gz
PYTHON_PYDYF_SITE = https://files.pythonhosted.org/packages/18/dc/b607bbc7c15327c5d5ec25681a3707c847906134925d21a26ec6e7416a4a
PYTHON_PYDYF_SETUP_TYPE = flit
PYTHON_PYDYF_LICENSE = BSD-3-Clause
PYTHON_PYDYF_LICENSE_FILES = LICENSE

$(eval $(python-package))
