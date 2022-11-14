################################################################################
#
# python-mutagen
#
################################################################################

PYTHON_MUTAGEN_VERSION = 1.45.1
PYTHON_MUTAGEN_SOURCE = mutagen-$(PYTHON_MUTAGEN_VERSION).tar.gz
PYTHON_MUTAGEN_SITE = https://files.pythonhosted.org/packages/f3/d9/2232a4cb9a98e2d2501f7e58d193bc49c956ef23756d7423ba1bd87e386d
PYTHON_MUTAGEN_LICENSE = GPL-2.0
PYTHON_MUTAGEN_LICENSE_FILES = COPYING
PYTHON_MUTAGEN_SETUP_TYPE = setuptools

$(eval $(python-package))
