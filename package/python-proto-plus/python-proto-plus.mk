################################################################################
#
# python-proto-plus
#
################################################################################

PYTHON_PROTO_PLUS_VERSION = 1.27.0
PYTHON_PROTO_PLUS_SOURCE = proto_plus-$(PYTHON_PROTO_PLUS_VERSION).tar.gz
PYTHON_PROTO_PLUS_SITE = https://files.pythonhosted.org/packages/01/89/9cbe2f4bba860e149108b683bc2efec21f14d5f7ed6e25562ad86acbc373
PYTHON_PROTO_PLUS_SETUP_TYPE = setuptools
PYTHON_PROTO_PLUS_LICENSE = Apache-2.0
PYTHON_PROTO_PLUS_LICENSE_FILES = LICENSE

$(eval $(python-package))
