################################################################################
#
# python-magic-wormhole-transit-relay
#
################################################################################

PYTHON_MAGIC_WORMHOLE_TRANSIT_RELAY_VERSION = 0.3.1
PYTHON_MAGIC_WORMHOLE_TRANSIT_RELAY_SOURCE = magic-wormhole-transit-relay-$(PYTHON_MAGIC_WORMHOLE_TRANSIT_RELAY_VERSION).tar.gz
PYTHON_MAGIC_WORMHOLE_TRANSIT_RELAY_SITE = https://files.pythonhosted.org/packages/be/81/c5c19ea32d1d770f2513503fef4589c6958ae9b44c03ea121e9fbc74c704
PYTHON_MAGIC_WORMHOLE_TRANSIT_RELAY_SETUP_TYPE = setuptools
PYTHON_MAGIC_WORMHOLE_TRANSIT_RELAY_LICENSE = MIT
PYTHON_MAGIC_WORMHOLE_TRANSIT_RELAY_LICENSE_FILES = LICENSE

$(eval $(python-package))
