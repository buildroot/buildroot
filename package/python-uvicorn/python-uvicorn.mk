################################################################################
#
# python-uvicorn
#
################################################################################

PYTHON_UVICORN_VERSION = 0.34.0
PYTHON_UVICORN_SOURCE = uvicorn-$(PYTHON_UVICORN_VERSION).tar.gz
PYTHON_UVICORN_SITE = https://files.pythonhosted.org/packages/4b/4d/938bd85e5bf2edeec766267a5015ad969730bb91e31b44021dfe8b22df6c
PYTHON_UVICORN_SETUP_TYPE = hatch
PYTHON_UVICORN_LICENSE = BSD-3-Clause
PYTHON_UVICORN_LICENSE_FILES = LICENSE.md
PYTHON_UVICORN_CPE_ID_VENDOR = encode
PYTHON_UVICORN_CPE_ID_PRODUCT = uvicorn

$(eval $(python-package))
