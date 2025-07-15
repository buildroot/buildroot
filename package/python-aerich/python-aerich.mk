################################################################################
#
# python-aerich
#
################################################################################

PYTHON_AERICH_VERSION = 0.9.1
PYTHON_AERICH_SOURCE = aerich-$(PYTHON_AERICH_VERSION).tar.gz
PYTHON_AERICH_SITE = https://files.pythonhosted.org/packages/a5/98/75c6e3053a14a14ffe86e2435698b960abe0bf03c114e67f966d92ff19e7
PYTHON_AERICH_SETUP_TYPE = poetry
PYTHON_AERICH_LICENSE = Apache-2.0
PYTHON_AERICH_LICENSE_FILES = LICENSE

$(eval $(python-package))
