################################################################################
#
# python-aerich
#
################################################################################

PYTHON_AERICH_VERSION = 0.8.2
PYTHON_AERICH_SOURCE = aerich-$(PYTHON_AERICH_VERSION).tar.gz
PYTHON_AERICH_SITE = https://files.pythonhosted.org/packages/dc/d1/701a44d8f7fdccf700400ce16a26c679b3f4e36de9fb86c3d9f55f64b07f
PYTHON_AERICH_SETUP_TYPE = poetry
PYTHON_AERICH_LICENSE = Apache-2.0
PYTHON_AERICH_LICENSE_FILES = LICENSE

$(eval $(python-package))
