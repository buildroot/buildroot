################################################################################
#
# python-tomlkit
#
################################################################################

PYTHON_TOMLKIT_VERSION = 0.15.2
PYTHON_TOMLKIT_SOURCE = tomlkit-$(PYTHON_TOMLKIT_VERSION).tar.gz
PYTHON_TOMLKIT_SITE = https://files.pythonhosted.org/packages/08/72/fc01563df95c189a9f65850096bdc205bc2fe37da6c740cd64afaf18d07e
PYTHON_TOMLKIT_SETUP_TYPE = poetry
PYTHON_TOMLKIT_LICENSE = MIT
PYTHON_TOMLKIT_LICENSE_FILES = LICENSE

$(eval $(python-package))
$(eval $(host-python-package))
