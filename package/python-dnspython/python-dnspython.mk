################################################################################
#
# python-dnspython
#
################################################################################

PYTHON_DNSPYTHON_VERSION = 2.9.1
PYTHON_DNSPYTHON_SOURCE = dnspython-$(PYTHON_DNSPYTHON_VERSION).tar.gz
PYTHON_DNSPYTHON_SITE = https://files.pythonhosted.org/packages/91/21/7fcd6780f61e9756aafaea760560509bb4111375daa2e23c1be7a89f33f1
PYTHON_DNSPYTHON_LICENSE = ISC
PYTHON_DNSPYTHON_LICENSE_FILES = LICENSE
PYTHON_DNSPYTHON_SETUP_TYPE = pep517
PYTHON_DNSPYTHON_DEPENDENCIES = host-python-uv-build
HOST_PYTHON_DNSPYTHON_DEPENDENCIES = host-python-uv-build

$(eval $(python-package))
$(eval $(host-python-package))
