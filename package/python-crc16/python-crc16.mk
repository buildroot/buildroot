################################################################################
#
# python-crc16
#
################################################################################

PYTHON_CRC16_VERSION = 0.1.1
PYTHON_CRC16_SOURCE = crc16-$(PYTHON_CRC16_VERSION).tar.gz
PYTHON_CRC16_SITE = https://files.pythonhosted.org/packages/a6/e0/70a44c4385f2b33df82e518005aae16b5c1feaf082c73c0acebe3426fc0a
PYTHON_CRC16_LICENSE = LGPL-3.0+
PYTHON_CRC16_LICENSE_FILES = COPYING.txt
PYTHON_CRC16_SETUP_TYPE = setuptools

$(eval $(python-package))
