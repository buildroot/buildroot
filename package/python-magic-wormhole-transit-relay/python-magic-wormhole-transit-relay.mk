################################################################################
#
# python-magic-wormhole-transit-relay
#
################################################################################

PYTHON_MAGIC_WORMHOLE_TRANSIT_RELAY_VERSION = 0.4.0
PYTHON_MAGIC_WORMHOLE_TRANSIT_RELAY_SOURCE = magic-wormhole-transit-relay-$(PYTHON_MAGIC_WORMHOLE_TRANSIT_RELAY_VERSION).tar.gz
PYTHON_MAGIC_WORMHOLE_TRANSIT_RELAY_SITE = https://files.pythonhosted.org/packages/d0/87/cb71073e53ea7e1b6f892c52e4114caea81b887a7d34e665b15dc81d669e
PYTHON_MAGIC_WORMHOLE_TRANSIT_RELAY_SETUP_TYPE = setuptools
PYTHON_MAGIC_WORMHOLE_TRANSIT_RELAY_LICENSE = MIT
PYTHON_MAGIC_WORMHOLE_TRANSIT_RELAY_LICENSE_FILES = LICENSE

$(eval $(python-package))
