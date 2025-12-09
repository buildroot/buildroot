################################################################################
#
# python-aiofiles
#
################################################################################

PYTHON_AIOFILES_VERSION = 25.1.0
PYTHON_AIOFILES_SOURCE = aiofiles-$(PYTHON_AIOFILES_VERSION).tar.gz
PYTHON_AIOFILES_SITE = https://files.pythonhosted.org/packages/41/c3/534eac40372d8ee36ef40df62ec129bee4fdb5ad9706e58a29be53b2c970
PYTHON_AIOFILES_SETUP_TYPE = hatch
PYTHON_AIOFILES_LICENSE = Apache-2.0
PYTHON_AIOFILES_LICENSE_FILES = LICENSE
PYTHON_AIOFILES_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
