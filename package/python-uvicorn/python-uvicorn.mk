################################################################################
#
# python-uvicorn
#
################################################################################

PYTHON_UVICORN_VERSION = 0.27.1
PYTHON_UVICORN_SOURCE = uvicorn-$(PYTHON_UVICORN_VERSION).tar.gz
PYTHON_UVICORN_SITE = https://files.pythonhosted.org/packages/09/d8/8aa69c76585035ca81851d99c3b00fd6be050aefd478a5376ff9fc5feb69
PYTHON_UVICORN_SETUP_TYPE = pep517
PYTHON_UVICORN_LICENSE = BSD-3-Clause
PYTHON_UVICORN_LICENSE_FILES = LICENSE.md
PYTHON_UVICORN_CPE_ID_VENDOR = encode
PYTHON_UVICORN_CPE_ID_PRODUCT = uvicorn
PYTHON_UVICORN_DEPENDENCIES = host-python-hatchling

$(eval $(python-package))
