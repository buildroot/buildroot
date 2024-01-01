################################################################################
#
# python-asyncssh
#
################################################################################

PYTHON_ASYNCSSH_VERSION = 2.14.2
PYTHON_ASYNCSSH_SOURCE = asyncssh-$(PYTHON_ASYNCSSH_VERSION).tar.gz
PYTHON_ASYNCSSH_SITE = https://files.pythonhosted.org/packages/6c/f9/849f158fe50cdb0b1bf75009861865c9a30c3b5a0d62ad43bb5e00b10feb
PYTHON_ASYNCSSH_SETUP_TYPE = setuptools
PYTHON_ASYNCSSH_LICENSE = EPL-2.0 or GPL-2.0+
PYTHON_ASYNCSSH_LICENSE_FILES = LICENSE COPYRIGHT
PYTHON_ASYNCSSH_CPE_ID_VENDOR = asyncssh_project
PYTHON_ASYNCSSH_CPE_ID_PRODUCT = asyncssh

$(eval $(python-package))
