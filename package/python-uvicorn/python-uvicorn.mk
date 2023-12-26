################################################################################
#
# python-uvicorn
#
################################################################################

PYTHON_UVICORN_VERSION = 0.24.0.post1
PYTHON_UVICORN_SOURCE = uvicorn-$(PYTHON_UVICORN_VERSION).tar.gz
PYTHON_UVICORN_SITE = https://files.pythonhosted.org/packages/e5/84/d43ce8fe6b31a316ef0ed04ea0d58cab981bdf7f17f8423491fa8b4f50b6
PYTHON_UVICORN_SETUP_TYPE = pep517
PYTHON_UVICORN_LICENSE = BSD-3-Clause
PYTHON_UVICORN_LICENSE_FILES = LICENSE.md
PYTHON_UVICORN_CPE_ID_VENDOR = encode
PYTHON_UVICORN_CPE_ID_PRODUCT = uvicorn
PYTHON_UVICORN_DEPENDENCIES = host-python-hatchling

$(eval $(python-package))
