################################################################################
#
# python-jsonschema
#
################################################################################

PYTHON_JSONSCHEMA_VERSION = 4.23.0
PYTHON_JSONSCHEMA_SOURCE = jsonschema-$(PYTHON_JSONSCHEMA_VERSION).tar.gz
PYTHON_JSONSCHEMA_SITE = https://files.pythonhosted.org/packages/38/2e/03362ee4034a4c917f697890ccd4aec0800ccf9ded7f511971c75451deec
PYTHON_JSONSCHEMA_SETUP_TYPE = hatch
PYTHON_JSONSCHEMA_LICENSE = MIT
PYTHON_JSONSCHEMA_LICENSE_FILES = COPYING json/LICENSE
PYTHON_JSONSCHEMA_DEPENDENCIES = \
	host-python-hatch-fancy-pypi-readme \
	host-python-hatch-vcs

HOST_PYTHON_JSONSCHEMA_DEPENDENCIES = \
	host-python-hatch-fancy-pypi-readme \
	host-python-hatch-vcs

# This is a runtime dependency, but we don't have the concept of
# runtime dependencies for host packages.
HOST_PYTHON_JSONSCHEMA_DEPENDENCIES += \
	host-python-attrs \
	host-python-jsonschema-specifications \
	host-python-referencing \
	host-python-rpds-py

$(eval $(python-package))
$(eval $(host-python-package))
