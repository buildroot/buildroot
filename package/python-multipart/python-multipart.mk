################################################################################
#
# python-multipart
#
################################################################################

PYTHON_MULTIPART_VERSION = 0.0.9
PYTHON_MULTIPART_SOURCE = python_multipart-$(PYTHON_MULTIPART_VERSION).tar.gz
PYTHON_MULTIPART_SITE = https://files.pythonhosted.org/packages/5c/0f/9c55ac6c84c0336e22a26fa84ca6c51d58d7ac3a2d78b0dfa8748826c883
PYTHON_MULTIPART_SETUP_TYPE = pep517
PYTHON_MULTIPART_LICENSE = Apache-2.0
PYTHON_MULTIPART_LICENSE_FILES = LICENSE.txt
PYTHON_MULTIPART_DEPENDENCIES = host-python-hatchling

$(eval $(python-package))
