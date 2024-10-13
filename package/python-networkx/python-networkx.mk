################################################################################
#
# python-networkx
#
################################################################################

PYTHON_NETWORKX_VERSION = 3.4.1
PYTHON_NETWORKX_SOURCE = networkx-$(PYTHON_NETWORKX_VERSION).tar.gz
PYTHON_NETWORKX_SITE = https://files.pythonhosted.org/packages/36/2b/20ad9eecdda3f1b0dc63fb8f82d2ea99163dbca08bfa392594fc2ed81869
PYTHON_NETWORKX_LICENSE = BSD-3-Clause
PYTHON_NETWORKX_LICENSE_FILES = LICENSE.txt
PYTHON_NETWORKX_CPE_ID_VENDOR = python
PYTHON_NETWORKX_CPE_ID_PRODUCT = networkx
PYTHON_NETWORKX_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
