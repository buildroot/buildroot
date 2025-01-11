################################################################################
#
# python-magic-wormhole-mailbox-server
#
################################################################################

PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_VERSION = 0.5.1
PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_SOURCE = magic-wormhole-mailbox-server-$(PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_VERSION).tar.gz
PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_SITE = https://files.pythonhosted.org/packages/9d/5c/71566147af3f28017035ebe69ce7253ea26917225ae7c39b964578541bff
PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_SETUP_TYPE = setuptools
PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_LICENSE = MIT
PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_LICENSE_FILES = LICENSE

$(eval $(python-package))
