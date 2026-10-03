################################################################################
#
# python-magic-wormhole-mailbox-server
#
################################################################################

PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_VERSION = 0.8.0
PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_SOURCE = magic_wormhole_mailbox_server-$(PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_VERSION).tar.gz
PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_SITE = https://files.pythonhosted.org/packages/ae/ad/6670956e0e464c43b6366b274e12839ba6cae17e714dd68a73cd2a9d81d8
PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_SETUP_TYPE = setuptools
PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_LICENSE = MIT
PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER_LICENSE_FILES = LICENSE

$(eval $(python-package))
