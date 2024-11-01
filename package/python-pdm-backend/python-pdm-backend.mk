################################################################################
#
# python-pdm-backend
#
################################################################################

PYTHON_PDM_BACKEND_VERSION = 2.4.3
PYTHON_PDM_BACKEND_SOURCE = pdm_backend-$(PYTHON_PDM_BACKEND_VERSION).tar.gz
PYTHON_PDM_BACKEND_SITE = https://files.pythonhosted.org/packages/d9/bf/d75d568521cef171ae9138d9ab55c169a98ee803853ca87b7096e4636d5b
PYTHON_PDM_BACKEND_SETUP_TYPE = pep517
PYTHON_PDM_BACKEND_LICENSE = MIT
PYTHON_PDM_BACKEND_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
