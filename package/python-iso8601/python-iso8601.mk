################################################################################
#
# python-iso8601
#
################################################################################

PYTHON_ISO8601_VERSION = 1.1.0
PYTHON_ISO8601_SOURCE = iso8601-$(PYTHON_ISO8601_VERSION).tar.gz
PYTHON_ISO8601_SITE = https://files.pythonhosted.org/packages/31/8c/1c342fdd2f4af0857684d16af766201393ef53318c15fa785fcb6c3b7c32
PYTHON_ISO8601_SETUP_TYPE = setuptools
PYTHON_ISO8601_LICENSE = MIT
PYTHON_ISO8601_LICENSE_FILES = LICENSE

$(eval $(python-package))
