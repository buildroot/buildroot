################################################################################
#
# python-networkx
#
################################################################################

PYTHON_NETWORKX_VERSION = 3.4.2
PYTHON_NETWORKX_SOURCE = networkx-$(PYTHON_NETWORKX_VERSION).tar.gz
PYTHON_NETWORKX_SITE = https://files.pythonhosted.org/packages/fd/1d/06475e1cd5264c0b870ea2cc6fdb3e37177c1e565c43f56ff17a10e3937f
PYTHON_NETWORKX_LICENSE = BSD-3-Clause
PYTHON_NETWORKX_LICENSE_FILES = LICENSE.txt
PYTHON_NETWORKX_CPE_ID_VENDOR = python
PYTHON_NETWORKX_CPE_ID_PRODUCT = networkx
PYTHON_NETWORKX_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
