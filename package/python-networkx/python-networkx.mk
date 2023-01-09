################################################################################
#
# python-networkx
#
################################################################################

PYTHON_NETWORKX_VERSION = 3.0
PYTHON_NETWORKX_SOURCE = networkx-$(PYTHON_NETWORKX_VERSION).tar.gz
PYTHON_NETWORKX_SITE = https://files.pythonhosted.org/packages/99/f9/d45c9ecf50a6b67a200e0bbd324201b5cd777dfc0e6c8f6d1620ce5a7ada
PYTHON_NETWORKX_LICENSE = BSD-3-Clause
PYTHON_NETWORKX_LICENSE_FILES = LICENSE.txt
PYTHON_NETWORKX_CPE_ID_VENDOR = python
PYTHON_NETWORKX_CPE_ID_PRODUCT = networkx
PYTHON_NETWORKX_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
