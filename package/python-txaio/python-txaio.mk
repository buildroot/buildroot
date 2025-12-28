################################################################################
#
# python-txaio
#
################################################################################

PYTHON_TXAIO_VERSION = 25.12.2
PYTHON_TXAIO_SOURCE = txaio-$(PYTHON_TXAIO_VERSION).tar.gz
PYTHON_TXAIO_SITE = https://files.pythonhosted.org/packages/7f/67/ea9c9ddbaa3e0b4d53c91f8778a33e42045be352dc7200ed2b9aaa7dc229
PYTHON_TXAIO_LICENSE = MIT
PYTHON_TXAIO_LICENSE_FILES = LICENSE
PYTHON_TXAIO_SETUP_TYPE = hatch

$(eval $(python-package))
