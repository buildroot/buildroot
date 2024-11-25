################################################################################
#
# python-u-msgpack
#
################################################################################

PYTHON_U_MSGPACK_VERSION = 2.8.0
PYTHON_U_MSGPACK_SOURCE = u-msgpack-python-$(PYTHON_U_MSGPACK_VERSION).tar.gz
PYTHON_U_MSGPACK_SITE = https://files.pythonhosted.org/packages/36/9d/a40411a475e7d4838994b7f6bcc6bfca9acc5b119ce3a7503608c4428b49
PYTHON_U_MSGPACK_SETUP_TYPE = setuptools
PYTHON_U_MSGPACK_LICENSE = MIT
PYTHON_U_MSGPACK_LICENSE_FILES = LICENSE

$(eval $(python-package))
