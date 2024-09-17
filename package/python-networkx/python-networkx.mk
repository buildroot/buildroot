################################################################################
#
# python-networkx
#
################################################################################

PYTHON_NETWORKX_VERSION = 3.3
PYTHON_NETWORKX_SOURCE = networkx-$(PYTHON_NETWORKX_VERSION).tar.gz
PYTHON_NETWORKX_SITE = https://files.pythonhosted.org/packages/04/e6/b164f94c869d6b2c605b5128b7b0cfe912795a87fc90e78533920001f3ec
PYTHON_NETWORKX_LICENSE = BSD-3-Clause
PYTHON_NETWORKX_LICENSE_FILES = LICENSE.txt
PYTHON_NETWORKX_CPE_ID_VENDOR = python
PYTHON_NETWORKX_CPE_ID_PRODUCT = networkx
PYTHON_NETWORKX_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
