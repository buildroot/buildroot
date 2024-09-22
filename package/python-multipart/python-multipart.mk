################################################################################
#
# python-multipart
#
################################################################################

PYTHON_MULTIPART_VERSION = 0.0.10
PYTHON_MULTIPART_SOURCE = python_multipart-$(PYTHON_MULTIPART_VERSION).tar.gz
PYTHON_MULTIPART_SITE = https://files.pythonhosted.org/packages/f9/29/0e5c896ec896b4e501bafa80ab555bbf3bcb0d720e9e33f908179aeb1a61
PYTHON_MULTIPART_SETUP_TYPE = pep517
PYTHON_MULTIPART_LICENSE = Apache-2.0
PYTHON_MULTIPART_LICENSE_FILES = LICENSE.txt
PYTHON_MULTIPART_DEPENDENCIES = host-python-hatchling

$(eval $(python-package))
