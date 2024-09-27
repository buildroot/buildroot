################################################################################
#
# python-pydantic-settings
#
################################################################################

PYTHON_PYDANTIC_SETTINGS_VERSION = 2.5.2
PYTHON_PYDANTIC_SETTINGS_SOURCE = pydantic_settings-$(PYTHON_PYDANTIC_SETTINGS_VERSION).tar.gz
PYTHON_PYDANTIC_SETTINGS_SITE = https://files.pythonhosted.org/packages/68/27/0bed9dd26b93328b60a1402febc780e7be72b42847fa8b5c94b7d0aeb6d1
PYTHON_PYDANTIC_SETTINGS_SETUP_TYPE = pep517
PYTHON_PYDANTIC_SETTINGS_LICENSE = MIT
PYTHON_PYDANTIC_SETTINGS_LICENSE_FILES = LICENSE
PYTHON_PYDANTIC_SETTINGS_DEPENDENCIES = host-python-hatchling

$(eval $(python-package))
