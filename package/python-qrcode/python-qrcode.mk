################################################################################
#
# python-qrcode
#
################################################################################

PYTHON_QRCODE_VERSION = 8.0
PYTHON_QRCODE_SOURCE = qrcode-$(PYTHON_QRCODE_VERSION).tar.gz
PYTHON_QRCODE_SITE = https://files.pythonhosted.org/packages/d7/db/6fc9631cac1327f609d2c8ae3680ecd987a2e97472437f2de7ead1235156
PYTHON_QRCODE_SETUP_TYPE = poetry
PYTHON_QRCODE_LICENSE = BSD-3-Clause
PYTHON_QRCODE_LICENSE_FILES = LICENSE

$(eval $(python-package))
