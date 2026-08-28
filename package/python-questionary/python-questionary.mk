################################################################################
#
# python-questionary
#
################################################################################

PYTHON_QUESTIONARY_VERSION = 2.1.1
PYTHON_QUESTIONARY_SOURCE = questionary-$(PYTHON_QUESTIONARY_VERSION).tar.gz
PYTHON_QUESTIONARY_SITE = https://files.pythonhosted.org/packages/f6/45/eafb0bba0f9988f6a2520f9ca2df2c82ddfa8d67c95d6625452e97b204a5
PYTHON_QUESTIONARY_SETUP_TYPE = poetry
PYTHON_QUESTIONARY_LICENSE = MIT
PYTHON_QUESTIONARY_LICENSE_FILES = LICENSE

$(eval $(python-package))
