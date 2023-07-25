################################################################################
#
# python-pydyf
#
################################################################################

PYTHON_PYDYF_VERSION = 0.7.0
PYTHON_PYDYF_SOURCE = pydyf-$(PYTHON_PYDYF_VERSION).tar.gz
PYTHON_PYDYF_SITE = https://files.pythonhosted.org/packages/28/ec/b6b327f2a249a83022501b2f57844ca05b2b26e0cadf28648ea5c0f72aa6
PYTHON_PYDYF_SETUP_TYPE = flit
PYTHON_PYDYF_LICENSE = BSD-3-Clause
PYTHON_PYDYF_LICENSE_FILES = LICENSE

$(eval $(python-package))
