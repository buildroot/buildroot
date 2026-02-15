################################################################################
#
# python-rich
#
################################################################################

PYTHON_RICH_VERSION = 14.3.2
PYTHON_RICH_SOURCE = rich-$(PYTHON_RICH_VERSION).tar.gz
PYTHON_RICH_SITE = https://files.pythonhosted.org/packages/74/99/a4cab2acbb884f80e558b0771e97e21e939c5dfb460f488d19df485e8298
PYTHON_RICH_SETUP_TYPE = poetry
PYTHON_RICH_LICENSE = MIT
PYTHON_RICH_LICENSE_FILES = LICENSE

$(eval $(python-package))
