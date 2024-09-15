################################################################################
#
# python-proto-plus
#
################################################################################

PYTHON_PROTO_PLUS_VERSION = 1.24.0
PYTHON_PROTO_PLUS_SOURCE = proto-plus-$(PYTHON_PROTO_PLUS_VERSION).tar.gz
PYTHON_PROTO_PLUS_SITE = https://files.pythonhosted.org/packages/3e/fc/e9a65cd52c1330d8d23af6013651a0bc50b6d76bcbdf91fae7cd19c68f29
PYTHON_PROTO_PLUS_SETUP_TYPE = setuptools
PYTHON_PROTO_PLUS_LICENSE = Apache-2.0
PYTHON_PROTO_PLUS_LICENSE_FILES = LICENSE

$(eval $(python-package))
