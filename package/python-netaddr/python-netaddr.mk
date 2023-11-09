################################################################################
#
# python-netaddr
#
################################################################################

PYTHON_NETADDR_VERSION = 0.9.0
PYTHON_NETADDR_SOURCE = netaddr-$(PYTHON_NETADDR_VERSION).tar.gz
PYTHON_NETADDR_SITE = https://files.pythonhosted.org/packages/48/4c/2491bfdb868c3f40d985037fa64a3903c125f45d7d3025640e05715db7a3
PYTHON_NETADDR_LICENSE = BSD-3-Clause
PYTHON_NETADDR_LICENSE_FILES = LICENSE
PYTHON_NETADDR_SETUP_TYPE = setuptools

$(eval $(python-package))
