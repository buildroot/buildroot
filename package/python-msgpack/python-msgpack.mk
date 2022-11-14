################################################################################
#
# python-msgpack
#
################################################################################

PYTHON_MSGPACK_VERSION = 1.0.4
PYTHON_MSGPACK_SOURCE = msgpack-$(PYTHON_MSGPACK_VERSION).tar.gz
PYTHON_MSGPACK_SITE = https://files.pythonhosted.org/packages/22/44/0829b19ac243211d1d2bd759999aa92196c546518b0be91de9cacc98122a
PYTHON_MSGPACK_LICENSE = Apache-2.0
PYTHON_MSGPACK_LICENSE_FILES = COPYING
PYTHON_MSGPACK_SETUP_TYPE = setuptools

$(eval $(python-package))
