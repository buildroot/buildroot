################################################################################
#
# python-dnspython
#
################################################################################

PYTHON_DNSPYTHON_VERSION = 2.4.2
PYTHON_DNSPYTHON_SOURCE = dnspython-$(PYTHON_DNSPYTHON_VERSION).tar.gz
PYTHON_DNSPYTHON_SITE = https://files.pythonhosted.org/packages/65/2d/372a20e52a87b2ba0160997575809806111a72e18aa92738daccceb8d2b9
PYTHON_DNSPYTHON_LICENSE = ISC
PYTHON_DNSPYTHON_LICENSE_FILES = LICENSE
PYTHON_DNSPYTHON_SETUP_TYPE = setuptools
PYTHON_DNSPYTHON_DEPENDENCIES = host-python-setuptools-scm
HOST_PYTHON_DNSPYTHON_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
$(eval $(host-python-package))
