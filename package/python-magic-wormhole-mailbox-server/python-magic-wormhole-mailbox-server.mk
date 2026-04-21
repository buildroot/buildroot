################################################################################
#
# python-magic-wormhole-mailbox-server
#
################################################################################

PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_VERSION = 0.6.0
PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_SOURCE = magic_wormhole_mailbox_server-$(PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_VERSION).tar.gz
PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_SITE = https://files.pythonhosted.org/packages/source/m/magic_wormhole_mailbox_server
PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_SETUP_TYPE = setuptools
PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_LICENSE = MIT
PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_LICENSE_FILES = LICENSE

$(eval $(python-package))
