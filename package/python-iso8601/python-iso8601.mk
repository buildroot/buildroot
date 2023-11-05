################################################################################
#
# python-iso8601
#
################################################################################

PYTHON_ISO8601_VERSION = 2.1.0
PYTHON_ISO8601_SOURCE = iso8601-$(PYTHON_ISO8601_VERSION).tar.gz
PYTHON_ISO8601_SITE = https://files.pythonhosted.org/packages/b9/f3/ef59cee614d5e0accf6fd0cbba025b93b272e626ca89fb70a3e9187c5d15
PYTHON_ISO8601_SETUP_TYPE = setuptools
PYTHON_ISO8601_LICENSE = MIT
PYTHON_ISO8601_LICENSE_FILES = LICENSE

$(eval $(python-package))
