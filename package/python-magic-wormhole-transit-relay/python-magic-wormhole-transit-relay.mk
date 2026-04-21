################################################################################
#
# python-magic-wormhole-transit-relay
#
################################################################################

PYTHON_MAGIC_WORMHOLE_TRANSIT_RELAY_VERSION = 0.5.0
PYTHON_MAGIC_WORMHOLE_TRANSIT_RELAY_SOURCE = magic_wormhole_transit_relay-$(PYTHON_MAGIC_WORMHOLE_TRANSIT_RELAY_VERSION).tar.gz
PYTHON_MAGIC_WORMHOLE_TRANSIT_RELAY_SITE = https://files.pythonhosted.org/packages/source/m/magic_wormhole_transit_relay
PYTHON_MAGIC_WORMHOLE_TRANSIT_RELAY_SETUP_TYPE = setuptools
PYTHON_MAGIC_WORMHOLE_TRANSIT_RELAY_LICENSE = MIT
PYTHON_MAGIC_WORMHOLE_TRANSIT_RELAY_LICENSE_FILES = LICENSE

$(eval $(python-package))
