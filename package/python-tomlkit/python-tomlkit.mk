################################################################################
#
# python-tomlkit
#
################################################################################

PYTHON_TOMLKIT_VERSION = 0.13.2
PYTHON_TOMLKIT_SOURCE = tomlkit-$(PYTHON_TOMLKIT_VERSION).tar.gz
PYTHON_TOMLKIT_SITE = https://files.pythonhosted.org/packages/b1/09/a439bec5888f00a54b8b9f05fa94d7f901d6735ef4e55dcec9bc37b5d8fa
PYTHON_TOMLKIT_SETUP_TYPE = poetry
PYTHON_TOMLKIT_LICENSE = MIT
PYTHON_TOMLKIT_LICENSE_FILES = LICENSE

$(eval $(python-package))
$(eval $(host-python-package))
