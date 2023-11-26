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

# When set in the environment, whatever the value, MSGPACK_PUREPYTHON drives
# using the pure python implementation rather than rely on the C++ native code.
# So we can't force it to use C++; we can only force it to use pure python.
ifeq ($(BR2_INSTALL_LIBSTDCPP),)
PYTHON_MSGPACK_ENV = MSGPACK_PUREPYTHON=1
endif

$(eval $(python-package))
