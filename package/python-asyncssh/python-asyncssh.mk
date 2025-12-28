################################################################################
#
# python-asyncssh
#
################################################################################

PYTHON_ASYNCSSH_VERSION = 2.22.0
PYTHON_ASYNCSSH_SOURCE = asyncssh-$(PYTHON_ASYNCSSH_VERSION).tar.gz
PYTHON_ASYNCSSH_SITE = https://files.pythonhosted.org/packages/fc/d5/957886c316466349d55c4de6a688a10a98295c0b4429deb8db1a17f3eb19
PYTHON_ASYNCSSH_SETUP_TYPE = setuptools
PYTHON_ASYNCSSH_LICENSE = EPL-2.0 or GPL-2.0+
PYTHON_ASYNCSSH_LICENSE_FILES = LICENSE COPYRIGHT
PYTHON_ASYNCSSH_CPE_ID_VENDOR = asyncssh_project
PYTHON_ASYNCSSH_CPE_ID_PRODUCT = asyncssh

$(eval $(python-package))
