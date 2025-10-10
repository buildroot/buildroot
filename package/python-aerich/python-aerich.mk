################################################################################
#
# python-aerich
#
################################################################################

PYTHON_AERICH_VERSION = 0.9.2
PYTHON_AERICH_SOURCE = aerich-$(PYTHON_AERICH_VERSION).tar.gz
PYTHON_AERICH_SITE = https://files.pythonhosted.org/packages/c4/60/5d3885f531fab2cecec67510e7b821efc403940ed9eefd034b2c21350f3c
PYTHON_AERICH_SETUP_TYPE = pep517
PYTHON_AERICH_LICENSE = Apache-2.0
PYTHON_AERICH_LICENSE_FILES = LICENSE
PYTHON_AERICH_DEPENDENCIES = host-python-pdm-backend

$(eval $(python-package))
