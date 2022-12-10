################################################################################
#
# python-jsonschema
#
################################################################################

PYTHON_JSONSCHEMA_VERSION = 4.17.3
PYTHON_JSONSCHEMA_SOURCE = jsonschema-$(PYTHON_JSONSCHEMA_VERSION).tar.gz
PYTHON_JSONSCHEMA_SITE = https://files.pythonhosted.org/packages/36/3d/ca032d5ac064dff543aa13c984737795ac81abc9fb130cd2fcff17cfabc7
PYTHON_JSONSCHEMA_SETUP_TYPE = pep517
PYTHON_JSONSCHEMA_LICENSE = MIT
PYTHON_JSONSCHEMA_LICENSE_FILES = COPYING json/LICENSE
PYTHON_JSONSCHEMA_DEPENDENCIES = \
	host-python-hatchling \
	host-python-hatch-fancy-pypi-readme \
	host-python-hatch-vcs

$(eval $(python-package))
