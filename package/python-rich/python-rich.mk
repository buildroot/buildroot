################################################################################
#
# python-rich
#
################################################################################

PYTHON_RICH_VERSION = 14.1.0
PYTHON_RICH_SOURCE = rich-$(PYTHON_RICH_VERSION).tar.gz
PYTHON_RICH_SITE = https://files.pythonhosted.org/packages/fe/75/af448d8e52bf1d8fa6a9d089ca6c07ff4453d86c65c145d0a300bb073b9b
PYTHON_RICH_SETUP_TYPE = poetry
PYTHON_RICH_LICENSE = MIT
PYTHON_RICH_LICENSE_FILES = LICENSE

$(eval $(python-package))
