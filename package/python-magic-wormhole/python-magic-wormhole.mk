################################################################################
#
# python-magic-wormhole
#
################################################################################

PYTHON_MAGIC_WORMHOLE_VERSION = 0.24.0
PYTHON_MAGIC_WORMHOLE_SOURCE = magic_wormhole-$(PYTHON_MAGIC_WORMHOLE_VERSION).tar.gz
PYTHON_MAGIC_WORMHOLE_SITE = https://files.pythonhosted.org/packages/d7/8c/964308aeed7b828ca726da4bbfcc8f2bc89713b39ba768e24ce6331b30f3
PYTHON_MAGIC_WORMHOLE_SETUP_TYPE = setuptools
PYTHON_MAGIC_WORMHOLE_LICENSE = MIT
PYTHON_MAGIC_WORMHOLE_LICENSE_FILES = LICENSE
PYTHON_MAGIC_WORMHOLE_CPE_ID_VENDOR = magic_wormhole_project
PYTHON_MAGIC_WORMHOLE_CPE_ID_PRODUCT = magic_wormhole
PYTHON_MAGIC_WORMHOLE_DEPENDENCIES = host-python-versioneer

$(eval $(python-package))
