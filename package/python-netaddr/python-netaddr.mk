################################################################################
#
# python-netaddr
#
################################################################################

PYTHON_NETADDR_VERSION = 1.3.0
PYTHON_NETADDR_SOURCE = netaddr-$(PYTHON_NETADDR_VERSION).tar.gz
PYTHON_NETADDR_SITE = https://files.pythonhosted.org/packages/54/90/188b2a69654f27b221fba92fda7217778208532c962509e959a9cee5229d
PYTHON_NETADDR_LICENSE = BSD-3-Clause
PYTHON_NETADDR_LICENSE_FILES = LICENSE.rst
PYTHON_NETADDR_SETUP_TYPE = setuptools

$(eval $(python-package))
