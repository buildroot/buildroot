################################################################################
#
# python-jsonschema-specifications
#
################################################################################

PYTHON_JSONSCHEMA_SPECIFICATIONS_VERSION = 2023.12.1
PYTHON_JSONSCHEMA_SPECIFICATIONS_SOURCE = jsonschema_specifications-$(PYTHON_JSONSCHEMA_SPECIFICATIONS_VERSION).tar.gz
PYTHON_JSONSCHEMA_SPECIFICATIONS_SITE = https://files.pythonhosted.org/packages/f8/b9/cc0cc592e7c195fb8a650c1d5990b10175cf13b4c97465c72ec841de9e4b
PYTHON_JSONSCHEMA_SPECIFICATIONS_SETUP_TYPE = pep517
PYTHON_JSONSCHEMA_SPECIFICATIONS_LICENSE = MIT
PYTHON_JSONSCHEMA_SPECIFICATIONS_LICENSE_FILES = COPYING
PYTHON_JSONSCHEMA_SPECIFICATIONS_DEPENDENCIES = \
	host-python-hatchling \
	host-python-hatch-vcs

$(eval $(python-package))
