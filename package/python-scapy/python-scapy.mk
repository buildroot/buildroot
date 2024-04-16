################################################################################
#
# python-scapy
#
################################################################################

PYTHON_SCAPY_VERSION = 2.5.0
PYTHON_SCAPY_SOURCE = scapy-$(PYTHON_SCAPY_VERSION).tar.gz
PYTHON_SCAPY_SITE = https://files.pythonhosted.org/packages/67/a1/2a60d5b6f0fed297dd0c0311c887d5e8a30ba1250506585b897e5a662f4c
PYTHON_SCAPY_SETUP_TYPE = setuptools
PYTHON_SCAPY_LICENSE = GPL-2.0
PYTHON_SCAPY_LICENSE_FILES = LICENSE
PYTHON_SCAPY_CPE_ID_VENDOR = scapy
PYTHON_SCAPY_CPE_ID_PRODUCT = scapy

$(eval $(python-package))
