################################################################################
#
# python-bluezero
#
################################################################################

PYTHON_BLUEZERO_VERSION = 0.6.0
PYTHON_BLUEZERO_SOURCE = bluezero-$(PYTHON_BLUEZERO_VERSION).tar.gz
PYTHON_BLUEZERO_SITE = https://files.pythonhosted.org/packages/be/15/4a806580ffd359a03184776f37cf201298918f302b414b8a3e594d1be65c
PYTHON_BLUEZERO_SETUP_TYPE = setuptools
PYTHON_BLUEZERO_LICENSE = MIT
PYTHON_BLUEZERO_LICENSE_FILES = LICENSE

$(eval $(python-package))
