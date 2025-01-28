################################################################################
#
# python-proto-plus
#
################################################################################

PYTHON_PROTO_PLUS_VERSION = 1.26.0
PYTHON_PROTO_PLUS_SOURCE = proto_plus-$(PYTHON_PROTO_PLUS_VERSION).tar.gz
PYTHON_PROTO_PLUS_SITE = https://files.pythonhosted.org/packages/26/79/a5c6cbb42268cfd3ddc652dc526889044a8798c688a03ff58e5e92b743c8
PYTHON_PROTO_PLUS_SETUP_TYPE = setuptools
PYTHON_PROTO_PLUS_LICENSE = Apache-2.0
PYTHON_PROTO_PLUS_LICENSE_FILES = LICENSE

$(eval $(python-package))
