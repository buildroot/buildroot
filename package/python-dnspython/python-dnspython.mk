################################################################################
#
# python-dnspython
#
################################################################################

PYTHON_DNSPYTHON_VERSION = 2.6.1
PYTHON_DNSPYTHON_SOURCE = dnspython-$(PYTHON_DNSPYTHON_VERSION).tar.gz
PYTHON_DNSPYTHON_SITE = https://files.pythonhosted.org/packages/37/7d/c871f55054e403fdfd6b8f65fd6d1c4e147ed100d3e9f9ba1fe695403939
PYTHON_DNSPYTHON_LICENSE = ISC
PYTHON_DNSPYTHON_LICENSE_FILES = LICENSE
PYTHON_DNSPYTHON_SETUP_TYPE = pep517
PYTHON_DNSPYTHON_DEPENDENCIES = host-python-hatchling
HOST_PYTHON_DNSPYTHON_DEPENDENCIES = host-python-hatchling

$(eval $(python-package))
$(eval $(host-python-package))
