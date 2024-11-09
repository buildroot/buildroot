################################################################################
#
# python-scapy
#
################################################################################

PYTHON_SCAPY_VERSION = 2.6.1
PYTHON_SCAPY_SOURCE = scapy-$(PYTHON_SCAPY_VERSION).tar.gz
PYTHON_SCAPY_SITE = https://files.pythonhosted.org/packages/df/2f/035d3888f26d999e9680af8c7ddb7ce4ea0fd8d0e01c000de634c22dcf13
PYTHON_SCAPY_SETUP_TYPE = setuptools
PYTHON_SCAPY_LICENSE = GPL-2.0
PYTHON_SCAPY_LICENSE_FILES = LICENSE
PYTHON_SCAPY_CPE_ID_VENDOR = scapy
PYTHON_SCAPY_CPE_ID_PRODUCT = scapy

$(eval $(python-package))
