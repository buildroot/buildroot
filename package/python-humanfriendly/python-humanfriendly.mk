################################################################################
#
# python-humanfriendly
#
################################################################################

PYTHON_HUMANFRIENDLY_VERSION = 10.0
PYTHON_HUMANFRIENDLY_SOURCE = humanfriendly-$(PYTHON_HUMANFRIENDLY_VERSION).tar.gz
PYTHON_HUMANFRIENDLY_SITE = https://files.pythonhosted.org/packages/cc/3f/2c29224acb2e2df4d2046e4c73ee2662023c58ff5b113c4c1adac0886c43

PYTHON_HUMANFRIENDLY_LICENSE = MIT
PYTHON_HUMANFRIENDLY_LICENSE_FILES = LICENSE.txt

PYTHON_HUMANFRIENDLY_SETUP_TYPE = setuptools

$(eval $(python-package))
