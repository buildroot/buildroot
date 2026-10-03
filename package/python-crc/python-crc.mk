################################################################################
#
# python-crc
#
################################################################################

PYTHON_CRC_VERSION = 8.0.0
PYTHON_CRC_SOURCE = crc-$(PYTHON_CRC_VERSION).tar.gz
PYTHON_CRC_SITE = https://files.pythonhosted.org/packages/48/b8/79b2c41836b5f8503342956ef31218059159a3f556c31e76ef5c14233d4b
PYTHON_CRC_SETUP_TYPE = hatch
PYTHON_CRC_LICENSE = BSD-2-Clause
PYTHON_CRC_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
