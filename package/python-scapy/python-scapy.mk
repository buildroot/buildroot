################################################################################
#
# python-scapy
#
################################################################################

PYTHON_SCAPY_VERSION = 2.7.0
PYTHON_SCAPY_SOURCE = scapy-$(PYTHON_SCAPY_VERSION).tar.gz
PYTHON_SCAPY_SITE = https://files.pythonhosted.org/packages/82/97/7caec64f05eae3d305d83e7cce1ef2f337710513b89efb334f7278202e79
PYTHON_SCAPY_SETUP_TYPE = setuptools
PYTHON_SCAPY_LICENSE = GPL-2.0
PYTHON_SCAPY_LICENSE_FILES = LICENSE
PYTHON_SCAPY_CPE_ID_VENDOR = scapy
PYTHON_SCAPY_CPE_ID_PRODUCT = scapy

$(eval $(python-package))
