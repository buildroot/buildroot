################################################################################
#
# python-aerich
#
################################################################################

PYTHON_AERICH_VERSION = 0.10.1
PYTHON_AERICH_SOURCE = aerich-$(PYTHON_AERICH_VERSION).tar.gz
PYTHON_AERICH_SITE = https://files.pythonhosted.org/packages/47/a4/928e971cfdbff75cae335898b3a27643fc2564bc28e23efa182a8843e78c
PYTHON_AERICH_SETUP_TYPE = pep517
PYTHON_AERICH_LICENSE = Apache-2.0
PYTHON_AERICH_LICENSE_FILES = LICENSE
PYTHON_AERICH_DEPENDENCIES = host-python-pdm-backend

$(eval $(python-package))
