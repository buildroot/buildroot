################################################################################
#
# python-protobuf
#
################################################################################

PYTHON_PROTOBUF_VERSION = $(PROTOBUF_VERSION)
PYTHON_PROTOBUF_SOURCE = protobuf-7.$(PYTHON_PROTOBUF_VERSION).tar.gz
PYTHON_PROTOBUF_SITE = https://files.pythonhosted.org/packages/6b/6b/a0e95cad1ad7cc3f2c6821fcab91671bd5b78bd42afb357bb4765f29bc41

PYTHON_PROTOBUF_LICENSE = BSD-3-Clause
PYTHON_PROTOBUF_LICENSE_FILES = LICENSE
PYTHON_PROTOBUF_DEPENDENCIES = host-protobuf
PYTHON_PROTOBUF_SETUP_TYPE = setuptools

$(eval $(python-package))
