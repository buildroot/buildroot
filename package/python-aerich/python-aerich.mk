################################################################################
#
# python-aerich
#
################################################################################

PYTHON_AERICH_VERSION = 0.9.0
PYTHON_AERICH_SOURCE = aerich-$(PYTHON_AERICH_VERSION).tar.gz
PYTHON_AERICH_SITE = https://files.pythonhosted.org/packages/2f/4b/1facb78fea47f790040035b94fdcc31630fabe1bda49ebc7a4f374da1757
PYTHON_AERICH_SETUP_TYPE = poetry
PYTHON_AERICH_LICENSE = Apache-2.0
PYTHON_AERICH_LICENSE_FILES = LICENSE

$(eval $(python-package))
