################################################################################
#
# python-pdm-backend
#
################################################################################

PYTHON_PDM_BACKEND_VERSION = 2.4.5
PYTHON_PDM_BACKEND_SOURCE = pdm_backend-$(PYTHON_PDM_BACKEND_VERSION).tar.gz
PYTHON_PDM_BACKEND_SITE = https://files.pythonhosted.org/packages/4d/f2/59135ddc68636a33179a37c002abcb162a9811c9ce14469258e486bec012
PYTHON_PDM_BACKEND_SETUP_TYPE = pep517
PYTHON_PDM_BACKEND_LICENSE = MIT
PYTHON_PDM_BACKEND_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
