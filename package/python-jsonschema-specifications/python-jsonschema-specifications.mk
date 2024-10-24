################################################################################
#
# python-jsonschema-specifications
#
################################################################################

PYTHON_JSONSCHEMA_SPECIFICATIONS_VERSION = 2024.10.1
PYTHON_JSONSCHEMA_SPECIFICATIONS_SOURCE = jsonschema_specifications-$(PYTHON_JSONSCHEMA_SPECIFICATIONS_VERSION).tar.gz
PYTHON_JSONSCHEMA_SPECIFICATIONS_SITE = https://files.pythonhosted.org/packages/10/db/58f950c996c793472e336ff3655b13fbcf1e3b359dcf52dcf3ed3b52c352
PYTHON_JSONSCHEMA_SPECIFICATIONS_SETUP_TYPE = hatch
PYTHON_JSONSCHEMA_SPECIFICATIONS_LICENSE = MIT
PYTHON_JSONSCHEMA_SPECIFICATIONS_LICENSE_FILES = COPYING
PYTHON_JSONSCHEMA_SPECIFICATIONS_DEPENDENCIES = host-python-hatch-vcs

HOST_PYTHON_JSONSCHEMA_SPECIFICATIONS_DEPENDENCIES = host-python-hatch-vcs

# This is a runtime dependency, but we don't have the concept of
# runtime dependencies for host packages.
HOST_PYTHON_JSONSCHEMA_SPECIFICATIONS_DEPENDENCIES += \
	host-python-referencing

$(eval $(python-package))
$(eval $(host-python-package))
