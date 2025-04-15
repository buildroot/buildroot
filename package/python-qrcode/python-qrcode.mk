################################################################################
#
# python-qrcode
#
################################################################################

PYTHON_QRCODE_VERSION = 8.1
PYTHON_QRCODE_SOURCE = qrcode-$(PYTHON_QRCODE_VERSION).tar.gz
PYTHON_QRCODE_SITE = https://files.pythonhosted.org/packages/61/d4/d222d00f65c81945b55e8f64011c33cb11a2931957ba3e2845fb0874fffe
PYTHON_QRCODE_SETUP_TYPE = poetry
PYTHON_QRCODE_LICENSE = BSD-3-Clause
PYTHON_QRCODE_LICENSE_FILES = LICENSE

$(eval $(python-package))
