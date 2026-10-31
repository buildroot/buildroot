################################################################################
#
# python-pydantic-settings
#
################################################################################

PYTHON_PYDANTIC_SETTINGS_VERSION = 2.16.2
PYTHON_PYDANTIC_SETTINGS_SOURCE = pydantic_settings-$(PYTHON_PYDANTIC_SETTINGS_VERSION).tar.gz
PYTHON_PYDANTIC_SETTINGS_SITE = https://files.pythonhosted.org/packages/d0/31/21d21e0e38a8f5f7a7f0cde22820117b6d17d6bc36f348129527f915d7f4
PYTHON_PYDANTIC_SETTINGS_SETUP_TYPE = hatch
PYTHON_PYDANTIC_SETTINGS_LICENSE = MIT
PYTHON_PYDANTIC_SETTINGS_LICENSE_FILES = LICENSE

$(eval $(python-package))
