################################################################################
#
# python-referencing
#
################################################################################

PYTHON_REFERENCING_VERSION = 0.32.1
PYTHON_REFERENCING_SOURCE = referencing-$(PYTHON_REFERENCING_VERSION).tar.gz
PYTHON_REFERENCING_SITE = https://files.pythonhosted.org/packages/81/ce/910573eca7b1a1c6358b0dc0774ce1eeb81f4c98d4ee371f1c85f22040a1
PYTHON_REFERENCING_SETUP_TYPE = pep517
PYTHON_REFERENCING_LICENSE = MIT
PYTHON_REFERENCING_LICENSE_FILES = COPYING
PYTHON_REFERENCING_DEPENDENCIES = \
	host-python-hatchling \
	host-python-hatch-vcs

HOST_PYTHON_REFERENCING_DEPENDENCIES = \
	host-python-hatchling \
	host-python-hatch-vcs

# This is a runtime dependency, but we don't have the concept of
# runtime dependencies for host packages.
HOST_PYTHON_REFERENCING_DEPENDENCIES += \
	host-python-attrs \
	host-python-rpds-py

$(eval $(python-package))
$(eval $(host-python-package))
