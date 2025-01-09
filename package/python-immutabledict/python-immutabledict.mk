################################################################################
#
# python-immutabledict
#
################################################################################

PYTHON_IMMUTABLEDICT_VERSION = 4.2.1
PYTHON_IMMUTABLEDICT_SOURCE = immutabledict-$(PYTHON_IMMUTABLEDICT_VERSION).tar.gz
PYTHON_IMMUTABLEDICT_SITE = https://files.pythonhosted.org/packages/e0/c5/4240186fbabc58fba41bbe17c5f0cd37ffd4c0b85a5029ab104f946df175
PYTHON_IMMUTABLEDICT_SETUP_TYPE = poetry
PYTHON_IMMUTABLEDICT_LICENSE = MIT
PYTHON_IMMUTABLEDICT_LICENSE_FILES = LICENSE

$(eval $(python-package))
