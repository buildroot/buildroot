################################################################################
#
# python-tomlkit
#
################################################################################

PYTHON_TOMLKIT_VERSION = 0.13.3
PYTHON_TOMLKIT_SOURCE = tomlkit-$(PYTHON_TOMLKIT_VERSION).tar.gz
PYTHON_TOMLKIT_SITE = https://files.pythonhosted.org/packages/cc/18/0bbf3884e9eaa38819ebe46a7bd25dcd56b67434402b66a58c4b8e552575
PYTHON_TOMLKIT_SETUP_TYPE = poetry
PYTHON_TOMLKIT_LICENSE = MIT
PYTHON_TOMLKIT_LICENSE_FILES = LICENSE

$(eval $(python-package))
$(eval $(host-python-package))
