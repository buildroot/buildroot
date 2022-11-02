################################################################################
#
# python-humanize
#
################################################################################

PYTHON_HUMANIZE_VERSION = 4.4.0
PYTHON_HUMANIZE_SOURCE = humanize-$(PYTHON_HUMANIZE_VERSION).tar.gz
PYTHON_HUMANIZE_SITE = https://files.pythonhosted.org/packages/51/19/3e1adf0e7a8c8361496b085edcab2ddcd85410735a2b6fdd044247fc5b75
PYTHON_HUMANIZE_SETUP_TYPE = setuptools
PYTHON_HUMANIZE_LICENSE = MIT
PYTHON_HUMANIZE_LICENSE_FILES = LICENCE

$(eval $(python-package))
