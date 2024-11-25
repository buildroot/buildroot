################################################################################
#
# python-magic-wormhole-mailbox-server
#
################################################################################

PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_VERSION = 0.5.0
PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_SOURCE = magic-wormhole-mailbox-server-$(PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_VERSION).tar.gz
PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_SITE = https://files.pythonhosted.org/packages/1f/0b/0b6fda78c8a90d6c600da614c5a1962a4f24275e76d2e1bf763ee8df0b70
PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_SETUP_TYPE = setuptools
PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_LICENSE = MIT
PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_LICENSE_FILES = LICENSE

$(eval $(python-package))
