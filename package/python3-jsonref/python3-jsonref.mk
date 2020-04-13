################################################################################
#
# python-jsonref
#
################################################################################

PYTHON3_JSONREF_VERSION = 0.2
PYTHON3_JSONREF_SOURCE = jsonref-$(PYTHON3_JSONREF_VERSION).tar.gz
PYTHON3_JSONREF_SITE = https://pypi.python.org/packages/b3/cf/93d4f34d76863d4fb995cb8e3e4f29908304065ce6381e0349700c44ad0c
PYTHON3_JSONREF_LICENSE = MIT
PYTHON3_JSONREF_LICENSE_FILES = COPYING json/LICENSE
PYTHON3_JSONREF_SETUP_TYPE = setuptools

HOST_PYTHON3_JSONREF_NEEDS_HOST_PYTHON = python3
HOST_PYTHON3_JSONREF_DL_SUBDIR = python-jsonref

$(eval $(host-python-package))

