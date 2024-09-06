################################################################################
#
# python-asyncssh
#
################################################################################

PYTHON_ASYNCSSH_VERSION = 2.17.0
PYTHON_ASYNCSSH_SOURCE = asyncssh-$(PYTHON_ASYNCSSH_VERSION).tar.gz
PYTHON_ASYNCSSH_SITE = https://files.pythonhosted.org/packages/32/34/007ba4c65dc15ad394ff50d6ce272bcc028a8824ab1658c5fe5c480be515
PYTHON_ASYNCSSH_SETUP_TYPE = setuptools
PYTHON_ASYNCSSH_LICENSE = EPL-2.0 or GPL-2.0+
PYTHON_ASYNCSSH_LICENSE_FILES = LICENSE COPYRIGHT
PYTHON_ASYNCSSH_CPE_ID_VENDOR = asyncssh_project
PYTHON_ASYNCSSH_CPE_ID_PRODUCT = asyncssh

$(eval $(python-package))
