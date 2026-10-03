################################################################################
#
# python-txaio
#
################################################################################

PYTHON_TXAIO_VERSION = 26.6.1
PYTHON_TXAIO_SOURCE = txaio-$(PYTHON_TXAIO_VERSION).tar.gz
PYTHON_TXAIO_SITE = https://files.pythonhosted.org/packages/49/de/52729cab9d2c8de679ad015e87f11f69e092d6fb3084eb9a39735df09ce7
PYTHON_TXAIO_LICENSE = MIT
PYTHON_TXAIO_LICENSE_FILES = LICENSE
PYTHON_TXAIO_SETUP_TYPE = hatch

$(eval $(python-package))
