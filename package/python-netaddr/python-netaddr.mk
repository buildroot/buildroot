################################################################################
#
# python-netaddr
#
################################################################################

PYTHON_NETADDR_VERSION = 0.10.1
PYTHON_NETADDR_SOURCE = netaddr-$(PYTHON_NETADDR_VERSION).tar.gz
PYTHON_NETADDR_SITE = https://files.pythonhosted.org/packages/af/96/f4878091248450bbdebfbd01bf1d95821bd47eb38e756815a0431baa6b07
PYTHON_NETADDR_LICENSE = BSD-3-Clause
PYTHON_NETADDR_LICENSE_FILES = LICENSE
PYTHON_NETADDR_SETUP_TYPE = setuptools

$(eval $(python-package))
