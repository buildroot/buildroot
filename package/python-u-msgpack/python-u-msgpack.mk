################################################################################
#
# python-u-msgpack
#
################################################################################

PYTHON_U_MSGPACK_VERSION = 2.7.2
PYTHON_U_MSGPACK_SOURCE = u-msgpack-python-$(PYTHON_U_MSGPACK_VERSION).tar.gz
PYTHON_U_MSGPACK_SITE = https://files.pythonhosted.org/packages/44/a7/1cb4f059bbf72ea24364f9ba3ef682725af09969e29df988aa5437f0044e
PYTHON_U_MSGPACK_SETUP_TYPE = setuptools
PYTHON_U_MSGPACK_LICENSE = MIT
PYTHON_U_MSGPACK_LICENSE_FILES = LICENSE

$(eval $(python-package))
