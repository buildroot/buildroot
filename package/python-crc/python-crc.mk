################################################################################
#
# python-crc
#
################################################################################

PYTHON_CRC_VERSION = 7.1.0
PYTHON_CRC_SOURCE = crc-$(PYTHON_CRC_VERSION).tar.gz
PYTHON_CRC_SITE = https://files.pythonhosted.org/packages/7e/e6/c3488c35ecae290751466252e5ea01ef50fc67bfc1a9aba43983329b7025
PYTHON_CRC_SETUP_TYPE = poetry
PYTHON_CRC_LICENSE = BSD-2-Clause
PYTHON_CRC_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
