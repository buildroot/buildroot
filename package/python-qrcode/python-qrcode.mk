################################################################################
#
# python-qrcode
#
################################################################################

PYTHON_QRCODE_VERSION = 8.2
PYTHON_QRCODE_SOURCE = qrcode-$(PYTHON_QRCODE_VERSION).tar.gz
PYTHON_QRCODE_SITE = https://files.pythonhosted.org/packages/8f/b2/7fc2931bfae0af02d5f53b174e9cf701adbb35f39d69c2af63d4a39f81a9
PYTHON_QRCODE_SETUP_TYPE = poetry
PYTHON_QRCODE_LICENSE = BSD-3-Clause
PYTHON_QRCODE_LICENSE_FILES = LICENSE

$(eval $(python-package))
