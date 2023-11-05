################################################################################
#
# python-jsonschema-specifications
#
################################################################################

PYTHON_JSONSCHEMA_SPECIFICATIONS_VERSION = 2023.7.1
PYTHON_JSONSCHEMA_SPECIFICATIONS_SOURCE = jsonschema_specifications-$(PYTHON_JSONSCHEMA_SPECIFICATIONS_VERSION).tar.gz
PYTHON_JSONSCHEMA_SPECIFICATIONS_SITE = https://files.pythonhosted.org/packages/12/ce/eb5396b34c28cbac19a6a8632f0e03d309135d77285536258b82120198d8
PYTHON_JSONSCHEMA_SPECIFICATIONS_SETUP_TYPE = pep517
PYTHON_JSONSCHEMA_SPECIFICATIONS_LICENSE = MIT
PYTHON_JSONSCHEMA_SPECIFICATIONS_LICENSE_FILES = COPYING
PYTHON_JSONSCHEMA_SPECIFICATIONS_DEPENDENCIES = \
	host-python-hatchling \
	host-python-hatch-vcs

$(eval $(python-package))
