################################################################################
#
# python-asyncssh
#
################################################################################

PYTHON_ASYNCSSH_VERSION = 2.21.0
PYTHON_ASYNCSSH_SOURCE = asyncssh-$(PYTHON_ASYNCSSH_VERSION).tar.gz
PYTHON_ASYNCSSH_SITE = https://files.pythonhosted.org/packages/e8/d6/823ed5a227f7da70b33681e49eec4a36fae31b9296b27a8d6aead2bd3f77
PYTHON_ASYNCSSH_SETUP_TYPE = setuptools
PYTHON_ASYNCSSH_LICENSE = EPL-2.0 or GPL-2.0+
PYTHON_ASYNCSSH_LICENSE_FILES = LICENSE COPYRIGHT
PYTHON_ASYNCSSH_CPE_ID_VENDOR = asyncssh_project
PYTHON_ASYNCSSH_CPE_ID_PRODUCT = asyncssh

$(eval $(python-package))
