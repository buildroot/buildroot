################################################################################
#
# python-msgpack
#
################################################################################

PYTHON_MSGPACK_VERSION = 1.0.3
PYTHON_MSGPACK_SOURCE = msgpack-$(PYTHON_MSGPACK_VERSION).tar.gz
PYTHON_MSGPACK_SITE = https://files.pythonhosted.org/packages/61/3c/2206f39880d38ca7ad8ac1b28d2d5ca81632d163b2d68ef90e46409ca057
PYTHON_MSGPACK_LICENSE = Apache-2.0
PYTHON_MSGPACK_LICENSE_FILES = COPYING
PYTHON_MSGPACK_SETUP_TYPE = setuptools

$(eval $(python-package))
