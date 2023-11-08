################################################################################
#
# python-msgpack
#
################################################################################

PYTHON_MSGPACK_VERSION = 1.0.7
PYTHON_MSGPACK_SOURCE = msgpack-$(PYTHON_MSGPACK_VERSION).tar.gz
PYTHON_MSGPACK_SITE = https://files.pythonhosted.org/packages/c2/d5/5662032db1571110b5b51647aed4b56dfbd01bfae789fa566a2be1f385d1
PYTHON_MSGPACK_LICENSE = Apache-2.0
PYTHON_MSGPACK_LICENSE_FILES = COPYING
PYTHON_MSGPACK_SETUP_TYPE = setuptools

$(eval $(python-package))
