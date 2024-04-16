################################################################################
#
# python-magic-wormhole-mailbox-server
#
################################################################################

PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_VERSION = 0.4.1
PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_SOURCE = magic-wormhole-mailbox-server-$(PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_VERSION).tar.gz
PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_SITE = https://files.pythonhosted.org/packages/5b/ba/cbb211bc8f8bfdf7fb620d33331f07bcd889c7a28e7fd8a0de9029bb5a2f
PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_SETUP_TYPE = setuptools
PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_LICENSE = MIT
PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_LICENSE_FILES = LICENSE

$(eval $(python-package))
