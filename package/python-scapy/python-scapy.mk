################################################################################
#
# python-scapy
#
################################################################################

PYTHON_SCAPY_VERSION = 2.4.5
PYTHON_SCAPY_SOURCE = scapy-$(PYTHON_SCAPY_VERSION).tar.gz
PYTHON_SCAPY_SITE = https://files.pythonhosted.org/packages/85/47/c919432ca258f354bb2c1e645623f891603f185bfc7563d4a21f6432e7ed
PYTHON_SCAPY_SETUP_TYPE = setuptools
PYTHON_SCAPY_LICENSE = GPL-2.0
PYTHON_SCAPY_LICENSE_FILES = LICENSE
PYTHON_SCAPY_CPE_ID_VENDOR = scapy
PYTHON_SCAPY_CPE_ID_PRODUCT = scapy

$(eval $(python-package))
