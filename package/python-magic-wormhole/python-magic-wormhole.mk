################################################################################
#
# python-magic-wormhole
#
################################################################################

PYTHON_MAGIC_WORMHOLE_VERSION = 0.23.0
PYTHON_MAGIC_WORMHOLE_SOURCE = magic_wormhole-$(PYTHON_MAGIC_WORMHOLE_VERSION).tar.gz
PYTHON_MAGIC_WORMHOLE_SITE = https://files.pythonhosted.org/packages/source/m/magic_wormhole
PYTHON_MAGIC_WORMHOLE_SETUP_TYPE = setuptools
PYTHON_MAGIC_WORMHOLE_LICENSE = MIT
PYTHON_MAGIC_WORMHOLE_LICENSE_FILES = LICENSE
PYTHON_MAGIC_WORMHOLE_CPE_ID_VENDOR = magic_wormhole_project
PYTHON_MAGIC_WORMHOLE_CPE_ID_PRODUCT = magic_wormhole
PYTHON_MAGIC_WORMHOLE_DEPENDENCIES = host-python-versioneer

$(eval $(python-package))
