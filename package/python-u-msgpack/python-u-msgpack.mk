################################################################################
#
# python-u-msgpack
#
################################################################################

PYTHON_U_MSGPACK_VERSION = 2.7.1
PYTHON_U_MSGPACK_SOURCE = u-msgpack-python-$(PYTHON_U_MSGPACK_VERSION).tar.gz
PYTHON_U_MSGPACK_SITE = https://files.pythonhosted.org/packages/62/94/a4f485b628310534d377b3e7cb6f85b8066dc823dbff0e4421fb4227fb7e
PYTHON_U_MSGPACK_SETUP_TYPE = setuptools
PYTHON_U_MSGPACK_LICENSE = MIT
PYTHON_U_MSGPACK_LICENSE_FILES = LICENSE

$(eval $(python-package))
