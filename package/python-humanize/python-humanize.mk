################################################################################
#
# python-humanize
#
################################################################################

PYTHON_HUMANIZE_VERSION = 4.11.0
PYTHON_HUMANIZE_SOURCE = humanize-$(PYTHON_HUMANIZE_VERSION).tar.gz
PYTHON_HUMANIZE_SITE = https://files.pythonhosted.org/packages/6a/40/64a912b9330786df25e58127194d4a5a7441f818b400b155e748a270f924
PYTHON_HUMANIZE_SETUP_TYPE = hatch
PYTHON_HUMANIZE_LICENSE = MIT
PYTHON_HUMANIZE_LICENSE_FILES = LICENCE
PYTHON_HUMANIZE_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
