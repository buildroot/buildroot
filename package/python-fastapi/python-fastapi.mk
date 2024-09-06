################################################################################
#
# python-fastapi
#
################################################################################

PYTHON_FASTAPI_VERSION = 0.114.0
PYTHON_FASTAPI_SOURCE = fastapi-$(PYTHON_FASTAPI_VERSION).tar.gz
PYTHON_FASTAPI_SITE = https://files.pythonhosted.org/packages/20/1b/fb621a3bab915ac1c9ad06943eb5a2b2aa01cd63228d524bd45261278787
PYTHON_FASTAPI_SETUP_TYPE = pep517
PYTHON_FASTAPI_LICENSE = MIT
PYTHON_FASTAPI_LICENSE_FILES = LICENSE
PYTHON_FASTAPI_CPE_ID_VENDOR = fastapi_project
PYTHON_FASTAPI_CPE_ID_PRODUCT = fastapi
PYTHON_FASTAPI_DEPENDENCIES = host-python-pdm-backend

$(eval $(python-package))
