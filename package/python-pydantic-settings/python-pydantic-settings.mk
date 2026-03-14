################################################################################
#
# python-pydantic-settings
#
################################################################################

PYTHON_PYDANTIC_SETTINGS_VERSION = 2.13.1
PYTHON_PYDANTIC_SETTINGS_SOURCE = pydantic_settings-$(PYTHON_PYDANTIC_SETTINGS_VERSION).tar.gz
PYTHON_PYDANTIC_SETTINGS_SITE = https://files.pythonhosted.org/packages/52/6d/fffca34caecc4a3f97bda81b2098da5e8ab7efc9a66e819074a11955d87e
PYTHON_PYDANTIC_SETTINGS_SETUP_TYPE = hatch
PYTHON_PYDANTIC_SETTINGS_LICENSE = MIT
PYTHON_PYDANTIC_SETTINGS_LICENSE_FILES = LICENSE

$(eval $(python-package))
