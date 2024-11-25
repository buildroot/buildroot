################################################################################
#
# python-pydyf
#
################################################################################

PYTHON_PYDYF_VERSION = 0.11.0
PYTHON_PYDYF_SOURCE = pydyf-$(PYTHON_PYDYF_VERSION).tar.gz
PYTHON_PYDYF_SITE = https://files.pythonhosted.org/packages/2e/c2/97fc6ce4ce0045080dc99446def812081b57750ed8aa67bfdfafa4561fe5
PYTHON_PYDYF_SETUP_TYPE = flit
PYTHON_PYDYF_LICENSE = BSD-3-Clause
PYTHON_PYDYF_LICENSE_FILES = LICENSE

$(eval $(python-package))
