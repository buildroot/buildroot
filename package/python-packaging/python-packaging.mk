################################################################################
#
# python-packaging
#
################################################################################

PYTHON_PACKAGING_VERSION = 22.0
PYTHON_PACKAGING_SOURCE = packaging-$(PYTHON_PACKAGING_VERSION).tar.gz
PYTHON_PACKAGING_SITE = https://files.pythonhosted.org/packages/6b/f7/c240d7654ddd2d2f3f328d8468d4f1f876865f6b9038b146bec0a6737c65
PYTHON_PACKAGING_SETUP_TYPE = flit
PYTHON_PACKAGING_LICENSE = Apache-2.0 or BSD-2-Clause
PYTHON_PACKAGING_LICENSE_FILES = LICENSE LICENSE.APACHE LICENSE.BSD
HOST_PYTHON_PACKAGING_SETUP_TYPE = flit-bootstrap

$(eval $(python-package))
$(eval $(host-python-package))
