################################################################################
#
# python-uvicorn
#
################################################################################

PYTHON_UVICORN_VERSION = 0.30.1
PYTHON_UVICORN_SOURCE = uvicorn-$(PYTHON_UVICORN_VERSION).tar.gz
PYTHON_UVICORN_SITE = https://files.pythonhosted.org/packages/37/16/9f5ccaa1a76e5bfbaa0c67640e2db8a5214ca08d92a1b427fa1677b3da88
PYTHON_UVICORN_SETUP_TYPE = pep517
PYTHON_UVICORN_LICENSE = BSD-3-Clause
PYTHON_UVICORN_LICENSE_FILES = LICENSE.md
PYTHON_UVICORN_CPE_ID_VENDOR = encode
PYTHON_UVICORN_CPE_ID_PRODUCT = uvicorn
PYTHON_UVICORN_DEPENDENCIES = host-python-hatchling

$(eval $(python-package))
