################################################################################
#
# python-pdm-backend
#
################################################################################

PYTHON_PDM_BACKEND_VERSION = 2.3.1
PYTHON_PDM_BACKEND_SOURCE = pdm_backend-$(PYTHON_PDM_BACKEND_VERSION).tar.gz
PYTHON_PDM_BACKEND_SITE = https://files.pythonhosted.org/packages/70/f4/eaa4da6e3eaa32d902177e0b81563bb5526b2c387aa312d0dfbecf3c7109
PYTHON_PDM_BACKEND_SETUP_TYPE = pep517
PYTHON_PDM_BACKEND_LICENSE = MIT
PYTHON_PDM_BACKEND_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
