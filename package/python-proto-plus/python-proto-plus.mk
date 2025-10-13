################################################################################
#
# python-proto-plus
#
################################################################################

PYTHON_PROTO_PLUS_VERSION = 1.26.1
PYTHON_PROTO_PLUS_SOURCE = proto_plus-$(PYTHON_PROTO_PLUS_VERSION).tar.gz
PYTHON_PROTO_PLUS_SITE = https://files.pythonhosted.org/packages/f4/ac/87285f15f7cce6d4a008f33f1757fb5a13611ea8914eb58c3d0d26243468
PYTHON_PROTO_PLUS_SETUP_TYPE = setuptools
PYTHON_PROTO_PLUS_LICENSE = Apache-2.0
PYTHON_PROTO_PLUS_LICENSE_FILES = LICENSE

$(eval $(python-package))
