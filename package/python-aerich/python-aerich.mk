################################################################################
#
# python-aerich
#
################################################################################

PYTHON_AERICH_VERSION = 0.8.0
PYTHON_AERICH_SOURCE = aerich-$(PYTHON_AERICH_VERSION).tar.gz
PYTHON_AERICH_SITE = https://files.pythonhosted.org/packages/35/a5/fc8f6e70cedf47757c4738ed6f79420b9cca6ed1655daf527f86e73f3159
PYTHON_AERICH_SETUP_TYPE = poetry
PYTHON_AERICH_LICENSE = Apache-2.0
PYTHON_AERICH_LICENSE_FILES = LICENSE

$(eval $(python-package))
