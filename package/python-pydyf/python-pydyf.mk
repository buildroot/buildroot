################################################################################
#
# python-pydyf
#
################################################################################

PYTHON_PYDYF_VERSION = 0.3.0
PYTHON_PYDYF_SOURCE = pydyf-$(PYTHON_PYDYF_VERSION).tar.gz
PYTHON_PYDYF_SITE = https://files.pythonhosted.org/packages/4d/12/3341ead2313889e2bf49b18ab6d65f47f8a8fb82ccb91faaf74f5e51125f
PYTHON_PYDYF_SETUP_TYPE = flit
PYTHON_PYDYF_LICENSE = BSD-3-Clause
PYTHON_PYDYF_LICENSE_FILES = LICENSE

$(eval $(python-package))
