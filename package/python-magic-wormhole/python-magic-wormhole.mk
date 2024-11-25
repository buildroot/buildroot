################################################################################
#
# python-magic-wormhole
#
################################################################################

PYTHON_MAGIC_WORMHOLE_VERSION = 0.17.0
PYTHON_MAGIC_WORMHOLE_SOURCE = magic_wormhole-$(PYTHON_MAGIC_WORMHOLE_VERSION).tar.gz
PYTHON_MAGIC_WORMHOLE_SITE = https://files.pythonhosted.org/packages/1b/a8/32a54e75643206665f569dac6ab19727aefb508b148882f1d05dff003667
PYTHON_MAGIC_WORMHOLE_SETUP_TYPE = setuptools
PYTHON_MAGIC_WORMHOLE_LICENSE = MIT
PYTHON_MAGIC_WORMHOLE_LICENSE_FILES = LICENSE

$(eval $(python-package))
