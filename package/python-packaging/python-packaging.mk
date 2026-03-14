################################################################################
#
# python-packaging
#
################################################################################

PYTHON_PACKAGING_VERSION = 26.0
PYTHON_PACKAGING_SOURCE = packaging-$(PYTHON_PACKAGING_VERSION).tar.gz
PYTHON_PACKAGING_SITE = https://files.pythonhosted.org/packages/65/ee/299d360cdc32edc7d2cf530f3accf79c4fca01e96ffc950d8a52213bd8e4
PYTHON_PACKAGING_SETUP_TYPE = flit
PYTHON_PACKAGING_LICENSE = Apache-2.0 or BSD-2-Clause
PYTHON_PACKAGING_LICENSE_FILES = LICENSE LICENSE.APACHE LICENSE.BSD
HOST_PYTHON_PACKAGING_SETUP_TYPE = flit-bootstrap

$(eval $(python-package))
$(eval $(host-python-package))
