################################################################################
#
# python-qrcode
#
################################################################################

PYTHON_QRCODE_VERSION = 7.3.1
PYTHON_QRCODE_SOURCE = qrcode-$(PYTHON_QRCODE_VERSION).tar.gz
PYTHON_QRCODE_SITE = https://files.pythonhosted.org/packages/94/9f/31f33cdf3cf8f98e64c42582fb82f39ca718264df61957f28b0bbb09b134
PYTHON_QRCODE_SETUP_TYPE = setuptools
PYTHON_QRCODE_LICENSE = BSD-3-Clause
PYTHON_QRCODE_LICENSE_FILES = LICENSE

$(eval $(python-package))
