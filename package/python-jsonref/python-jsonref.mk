################################################################################
#
# python-jsonref
#
################################################################################

PYTHON_JSONREF_VERSION = 0.2
PYTHON_JSONREF_SOURCE = jsonref-$(PYTHON_JSONREF_VERSION).tar.gz
PYTHON_JSONREF_SITE = https://pypi.python.org/packages/b3/cf/93d4f34d76863d4fb995cb8e3e4f29908304065ce6381e0349700c44ad0c
PYTHON_JSONREF_LICENSE = MIT
PYTHON_JSONREF_LICENSE_FILES = COPYING json/LICENSE
PYTHON_JSONREF_SETUP_TYPE = setuptools
PYTHON_JSONREF_DEPENDENCIES = host-python-setuptools

$(eval $(host-python-package))
