################################################################################
#
# python-pdm-backend
#
################################################################################

PYTHON_PDM_BACKEND_VERSION = 2.5.0
PYTHON_PDM_BACKEND_SOURCE = pdm_backend-$(PYTHON_PDM_BACKEND_VERSION).tar.gz
PYTHON_PDM_BACKEND_SITE = https://files.pythonhosted.org/packages/fc/d5/a82f533ed51f91a2183faf67a1fcb3b759615ffeca95d05b3e7648bf84bf
PYTHON_PDM_BACKEND_SETUP_TYPE = pep517
PYTHON_PDM_BACKEND_LICENSE = MIT
PYTHON_PDM_BACKEND_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
