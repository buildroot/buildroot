################################################################################
#
# python-rich
#
################################################################################

PYTHON_RICH_VERSION = 14.3.3
PYTHON_RICH_SOURCE = rich-$(PYTHON_RICH_VERSION).tar.gz
PYTHON_RICH_SITE = https://files.pythonhosted.org/packages/b3/c6/f3b320c27991c46f43ee9d856302c70dc2d0fb2dba4842ff739d5f46b393
PYTHON_RICH_SETUP_TYPE = poetry
PYTHON_RICH_LICENSE = MIT
PYTHON_RICH_LICENSE_FILES = LICENSE

$(eval $(python-package))
