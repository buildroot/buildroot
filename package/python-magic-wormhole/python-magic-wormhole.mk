################################################################################
#
# python-magic-wormhole
#
################################################################################

PYTHON_MAGIC_WORMHOLE_VERSION = 0.12.0
PYTHON_MAGIC_WORMHOLE_SOURCE = magic-wormhole-$(PYTHON_MAGIC_WORMHOLE_VERSION).tar.gz
PYTHON_MAGIC_WORMHOLE_SITE = https://files.pythonhosted.org/packages/d4/62/5e4a86f7c4b111e016577f1b304063ebe604f430db15465ac58b13993608
PYTHON_MAGIC_WORMHOLE_SETUP_TYPE = setuptools
PYTHON_MAGIC_WORMHOLE_LICENSE = MIT
PYTHON_MAGIC_WORMHOLE_LICENSE_FILES = LICENSE

$(eval $(python-package))
