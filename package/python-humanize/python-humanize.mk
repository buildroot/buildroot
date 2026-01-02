################################################################################
#
# python-humanize
#
################################################################################

PYTHON_HUMANIZE_VERSION = 4.15.0
PYTHON_HUMANIZE_SOURCE = humanize-$(PYTHON_HUMANIZE_VERSION).tar.gz
PYTHON_HUMANIZE_SITE = https://files.pythonhosted.org/packages/ba/66/a3921783d54be8a6870ac4ccffcd15c4dc0dd7fcce51c6d63b8c63935276
PYTHON_HUMANIZE_SETUP_TYPE = hatch
PYTHON_HUMANIZE_LICENSE = MIT
PYTHON_HUMANIZE_LICENSE_FILES = LICENCE
PYTHON_HUMANIZE_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
