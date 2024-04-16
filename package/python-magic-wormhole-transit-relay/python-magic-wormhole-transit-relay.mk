################################################################################
#
# python-magic-wormhole-transit-relay
#
################################################################################

PYTHON_MAGIC_WORMHOLE_TRANSIT_RELAY_VERSION = 0.2.1
PYTHON_MAGIC_WORMHOLE_TRANSIT_RELAY_SOURCE = magic-wormhole-transit-relay-$(PYTHON_MAGIC_WORMHOLE_TRANSIT_RELAY_VERSION).tar.gz
PYTHON_MAGIC_WORMHOLE_TRANSIT_RELAY_SITE = https://files.pythonhosted.org/packages/21/c9/be25bb30e327037e009657960fc594d089b118c0d81cc6a200cad1bb3852
PYTHON_MAGIC_WORMHOLE_TRANSIT_RELAY_SETUP_TYPE = setuptools
PYTHON_MAGIC_WORMHOLE_TRANSIT_RELAY_LICENSE = MIT
PYTHON_MAGIC_WORMHOLE_TRANSIT_RELAY_LICENSE_FILES = LICENSE

$(eval $(python-package))
