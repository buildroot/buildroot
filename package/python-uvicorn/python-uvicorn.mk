################################################################################
#
# python-uvicorn
#
################################################################################

PYTHON_UVICORN_VERSION = 0.30.5
PYTHON_UVICORN_SOURCE = uvicorn-$(PYTHON_UVICORN_VERSION).tar.gz
PYTHON_UVICORN_SITE = https://files.pythonhosted.org/packages/c3/ad/02b1b412e43605aa6aac8d0392c383ff3f6ae8267b7864e48e3b5f3f601e
PYTHON_UVICORN_SETUP_TYPE = pep517
PYTHON_UVICORN_LICENSE = BSD-3-Clause
PYTHON_UVICORN_LICENSE_FILES = LICENSE.md
PYTHON_UVICORN_CPE_ID_VENDOR = encode
PYTHON_UVICORN_CPE_ID_PRODUCT = uvicorn
PYTHON_UVICORN_DEPENDENCIES = host-python-hatchling

$(eval $(python-package))
