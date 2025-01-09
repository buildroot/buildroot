################################################################################
#
# python-aerich
#
################################################################################

PYTHON_AERICH_VERSION = 0.8.1
PYTHON_AERICH_SOURCE = aerich-$(PYTHON_AERICH_VERSION).tar.gz
PYTHON_AERICH_SITE = https://files.pythonhosted.org/packages/4f/41/3c478b7a344abda866f2c644b056ebae638499bbe0eec0010e7361211774
PYTHON_AERICH_SETUP_TYPE = poetry
PYTHON_AERICH_LICENSE = Apache-2.0
PYTHON_AERICH_LICENSE_FILES = LICENSE

$(eval $(python-package))
