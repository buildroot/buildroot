################################################################################
#
# python-immutabledict
#
################################################################################

PYTHON_IMMUTABLEDICT_VERSION = 4.2.0
PYTHON_IMMUTABLEDICT_SOURCE = immutabledict-$(PYTHON_IMMUTABLEDICT_VERSION).tar.gz
PYTHON_IMMUTABLEDICT_SITE = https://files.pythonhosted.org/packages/55/f4/710c84db4d77767176342913ac6b25f43aaed6d0a0bdb9168a8d2936d9c7
PYTHON_IMMUTABLEDICT_SETUP_TYPE = poetry
PYTHON_IMMUTABLEDICT_LICENSE = MIT
PYTHON_IMMUTABLEDICT_LICENSE_FILES = LICENSE

$(eval $(python-package))
