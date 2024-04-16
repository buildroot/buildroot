################################################################################
#
# python-qrcode
#
################################################################################

PYTHON_QRCODE_VERSION = 7.4.2
PYTHON_QRCODE_SOURCE = qrcode-$(PYTHON_QRCODE_VERSION).tar.gz
PYTHON_QRCODE_SITE = https://files.pythonhosted.org/packages/30/35/ad6d4c5a547fe9a5baf85a9edbafff93fc6394b014fab30595877305fa59
PYTHON_QRCODE_SETUP_TYPE = setuptools
PYTHON_QRCODE_LICENSE = BSD-3-Clause
PYTHON_QRCODE_LICENSE_FILES = LICENSE

$(eval $(python-package))
