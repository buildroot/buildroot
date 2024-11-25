################################################################################
#
# python-aiofiles
#
################################################################################

PYTHON_AIOFILES_VERSION = 24.1.0
PYTHON_AIOFILES_SOURCE = aiofiles-$(PYTHON_AIOFILES_VERSION).tar.gz
PYTHON_AIOFILES_SITE = https://files.pythonhosted.org/packages/0b/03/a88171e277e8caa88a4c77808c20ebb04ba74cc4681bf1e9416c862de237
PYTHON_AIOFILES_SETUP_TYPE = hatch
PYTHON_AIOFILES_LICENSE = Apache-2.0
PYTHON_AIOFILES_LICENSE_FILES = LICENSE

$(eval $(python-package))
