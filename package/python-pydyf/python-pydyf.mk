################################################################################
#
# python-pydyf
#
################################################################################

PYTHON_PYDYF_VERSION = 0.2.0
PYTHON_PYDYF_SOURCE = pydyf-$(PYTHON_PYDYF_VERSION).tar.gz
PYTHON_PYDYF_SITE = https://files.pythonhosted.org/packages/3a/5e/4d4f5f77c706b0b871652cb4ccb98a52647ce917168a48e2b8cae742da1e
PYTHON_PYDYF_SETUP_TYPE = flit
PYTHON_PYDYF_LICENSE = BSD-3-Clause
PYTHON_PYDYF_LICENSE_FILES = LICENSE

$(eval $(python-package))
