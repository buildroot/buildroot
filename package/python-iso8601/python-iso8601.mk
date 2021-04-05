################################################################################
#
# python-iso8601
#
################################################################################

PYTHON_ISO8601_VERSION = 0.1.14
PYTHON_ISO8601_SOURCE = iso8601-$(PYTHON_ISO8601_VERSION).tar.gz
PYTHON_ISO8601_SITE = https://files.pythonhosted.org/packages/f9/ed/b97abc7877e5b253eef96a469f47d617b0ebcccc735405fa1a620c7ee833
PYTHON_ISO8601_SETUP_TYPE = setuptools
PYTHON_ISO8601_LICENSE = MIT
PYTHON_ISO8601_LICENSE_FILES = LICENSE

$(eval $(python-package))
