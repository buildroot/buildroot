################################################################################
#
# python-proto-plus
#
################################################################################

PYTHON_PROTO_PLUS_VERSION = 1.28.4
PYTHON_PROTO_PLUS_SOURCE = proto_plus-$(PYTHON_PROTO_PLUS_VERSION).tar.gz
PYTHON_PROTO_PLUS_SITE = https://files.pythonhosted.org/packages/40/a6/4fbadcc2044034449b3f8f0ce82dcf3005d53f37c136642103fd4836a31c
PYTHON_PROTO_PLUS_SETUP_TYPE = setuptools
PYTHON_PROTO_PLUS_LICENSE = Apache-2.0
PYTHON_PROTO_PLUS_LICENSE_FILES = LICENSE

$(eval $(python-package))
