################################################################################
#
# python-magic-wormhole
#
################################################################################

PYTHON_MAGIC_WORMHOLE_VERSION = 0.16.0
PYTHON_MAGIC_WORMHOLE_SOURCE = magic-wormhole-$(PYTHON_MAGIC_WORMHOLE_VERSION).tar.gz
PYTHON_MAGIC_WORMHOLE_SITE = https://files.pythonhosted.org/packages/1a/55/b82ace1c0c090bc6f629a93f3fb1ed60436731b166de2454d1585532c86f
PYTHON_MAGIC_WORMHOLE_SETUP_TYPE = setuptools
PYTHON_MAGIC_WORMHOLE_LICENSE = MIT
PYTHON_MAGIC_WORMHOLE_LICENSE_FILES = LICENSE

$(eval $(python-package))
