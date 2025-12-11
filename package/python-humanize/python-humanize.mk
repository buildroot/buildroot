################################################################################
#
# python-humanize
#
################################################################################

PYTHON_HUMANIZE_VERSION = 4.14.0
PYTHON_HUMANIZE_SOURCE = humanize-$(PYTHON_HUMANIZE_VERSION).tar.gz
PYTHON_HUMANIZE_SITE = https://files.pythonhosted.org/packages/b6/43/50033d25ad96a7f3845f40999b4778f753c3901a11808a584fed7c00d9f5
PYTHON_HUMANIZE_SETUP_TYPE = hatch
PYTHON_HUMANIZE_LICENSE = MIT
PYTHON_HUMANIZE_LICENSE_FILES = LICENCE
PYTHON_HUMANIZE_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
