################################################################################
#
# python-cycler
#
################################################################################

PYTHON_CYCLER_VERSION = 0.11.0
PYTHON_CYCLER_SOURCE = cycler-$(PYTHON_CYCLER_VERSION).tar.gz
PYTHON_CYCLER_SITE = https://files.pythonhosted.org/packages/34/45/a7caaacbfc2fa60bee42effc4bcc7d7c6dbe9c349500e04f65a861c15eb9
PYTHON_CYCLER_LICENSE = BSD-3-Clause
PYTHON_CYCLER_LICENSE_FILES = LICENSE
PYTHON_CYCLER_SETUP_TYPE = setuptools

$(eval $(python-package))
