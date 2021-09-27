################################################################################
#
# python-networkx
#
################################################################################

PYTHON_NETWORKX_VERSION = 2.6.3
PYTHON_NETWORKX_SOURCE = networkx-$(PYTHON_NETWORKX_VERSION).tar.gz
PYTHON_NETWORKX_SITE = https://files.pythonhosted.org/packages/97/ae/7497bc5e1c84af95e585e3f98585c9f06c627fac6340984c4243053e8f44
PYTHON_NETWORKX_LICENSE = BSD-3-Clause
PYTHON_NETWORKX_LICENSE_FILES = LICENSE.txt
PYTHON_NETWORKX_CPE_ID_VENDOR = python
PYTHON_NETWORKX_CPE_ID_PRODUCT = networkx
PYTHON_NETWORKX_SETUP_TYPE = setuptools
HOST_PYTHON_NETWORKX_DEPENDENCIES = host-python-decorator
HOST_PYTHON_NETWORKX_NEEDS_HOST_PYTHON = python3

$(eval $(python-package))
$(eval $(host-python-package))
