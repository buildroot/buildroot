################################################################################
#
# python-immutabledict
#
################################################################################

PYTHON_IMMUTABLEDICT_VERSION = 4.3.1
PYTHON_IMMUTABLEDICT_SOURCE = immutabledict-$(PYTHON_IMMUTABLEDICT_VERSION).tar.gz
PYTHON_IMMUTABLEDICT_SITE = https://files.pythonhosted.org/packages/1d/e6/718471048fea0366c3e3d1df3acfd914ca66d571cdffcf6d37bbcd725708
PYTHON_IMMUTABLEDICT_SETUP_TYPE = poetry
PYTHON_IMMUTABLEDICT_LICENSE = MIT
PYTHON_IMMUTABLEDICT_LICENSE_FILES = LICENSE

$(eval $(python-package))
