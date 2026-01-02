################################################################################
#
# python-magic-wormhole
#
################################################################################

PYTHON_MAGIC_WORMHOLE_VERSION = 0.22.0
PYTHON_MAGIC_WORMHOLE_SOURCE = magic_wormhole-$(PYTHON_MAGIC_WORMHOLE_VERSION).tar.gz
PYTHON_MAGIC_WORMHOLE_SITE = https://files.pythonhosted.org/packages/65/34/08813891da57999cf953e9c553193c900ff363c4cdfdd48a74f65536a883
PYTHON_MAGIC_WORMHOLE_SETUP_TYPE = setuptools
PYTHON_MAGIC_WORMHOLE_LICENSE = MIT
PYTHON_MAGIC_WORMHOLE_LICENSE_FILES = LICENSE
PYTHON_MAGIC_WORMHOLE_DEPENDENCIES = host-python-versioneer

$(eval $(python-package))
