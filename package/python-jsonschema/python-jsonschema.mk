################################################################################
#
# python-jsonschema
#
################################################################################

PYTHON_JSONSCHEMA_VERSION = 4.17.0
PYTHON_JSONSCHEMA_SOURCE = jsonschema-$(PYTHON_JSONSCHEMA_VERSION).tar.gz
PYTHON_JSONSCHEMA_SITE = https://files.pythonhosted.org/packages/3a/3d/0653047b9b2ed03d3e96012bc90cfc96227221193fbedd4dc0cbf5a0e342
PYTHON_JSONSCHEMA_SETUP_TYPE = pep517
PYTHON_JSONSCHEMA_LICENSE = MIT
PYTHON_JSONSCHEMA_LICENSE_FILES = COPYING json/LICENSE
PYTHON_JSONSCHEMA_DEPENDENCIES = \
	host-python-hatchling \
	host-python-hatch-fancy-pypi-readme \
	host-python-hatch-vcs

$(eval $(python-package))
