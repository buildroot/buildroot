################################################################################
#
# python-humanize
#
################################################################################

PYTHON_HUMANIZE_VERSION = 3.11.0
PYTHON_HUMANIZE_SOURCE = humanize-$(PYTHON_HUMANIZE_VERSION).tar.gz
PYTHON_HUMANIZE_SITE = https://files.pythonhosted.org/packages/a6/d0/e06993724937f2aab3e7085d137d453968aaac0f74661ef9c90528a79d61
PYTHON_HUMANIZE_SETUP_TYPE = setuptools
PYTHON_HUMANIZE_LICENSE = MIT
PYTHON_HUMANIZE_LICENSE_FILES = LICENCE

$(eval $(python-package))
