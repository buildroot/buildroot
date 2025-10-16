################################################################################
#
# python-pydantic-settings
#
################################################################################

PYTHON_PYDANTIC_SETTINGS_VERSION = 2.11.0
PYTHON_PYDANTIC_SETTINGS_SOURCE = pydantic_settings-$(PYTHON_PYDANTIC_SETTINGS_VERSION).tar.gz
PYTHON_PYDANTIC_SETTINGS_SITE = https://files.pythonhosted.org/packages/20/c5/dbbc27b814c71676593d1c3f718e6cd7d4f00652cefa24b75f7aa3efb25e
PYTHON_PYDANTIC_SETTINGS_SETUP_TYPE = hatch
PYTHON_PYDANTIC_SETTINGS_LICENSE = MIT
PYTHON_PYDANTIC_SETTINGS_LICENSE_FILES = LICENSE

$(eval $(python-package))
