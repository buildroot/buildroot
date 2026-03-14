################################################################################
#
# python-tomlkit
#
################################################################################

PYTHON_TOMLKIT_VERSION = 0.14.0
PYTHON_TOMLKIT_SOURCE = tomlkit-$(PYTHON_TOMLKIT_VERSION).tar.gz
PYTHON_TOMLKIT_SITE = https://files.pythonhosted.org/packages/c3/af/14b24e41977adb296d6bd1fb59402cf7d60ce364f90c890bd2ec65c43b5a
PYTHON_TOMLKIT_SETUP_TYPE = poetry
PYTHON_TOMLKIT_LICENSE = MIT
PYTHON_TOMLKIT_LICENSE_FILES = LICENSE

$(eval $(python-package))
$(eval $(host-python-package))
