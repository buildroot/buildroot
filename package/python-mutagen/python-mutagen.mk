################################################################################
#
# python-mutagen
#
################################################################################

PYTHON_MUTAGEN_VERSION = 1.47.0
PYTHON_MUTAGEN_SOURCE = mutagen-$(PYTHON_MUTAGEN_VERSION).tar.gz
PYTHON_MUTAGEN_SITE = https://files.pythonhosted.org/packages/81/e6/64bc71b74eef4b68e61eb921dcf72dabd9e4ec4af1e11891bbd312ccbb77
PYTHON_MUTAGEN_LICENSE = GPL-2.0
PYTHON_MUTAGEN_LICENSE_FILES = COPYING
PYTHON_MUTAGEN_SETUP_TYPE = setuptools

$(eval $(python-package))
