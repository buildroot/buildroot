################################################################################
#
# python-referencing
#
################################################################################

PYTHON_REFERENCING_VERSION = 0.36.2
PYTHON_REFERENCING_SOURCE = referencing-$(PYTHON_REFERENCING_VERSION).tar.gz
PYTHON_REFERENCING_SITE = https://files.pythonhosted.org/packages/2f/db/98b5c277be99dd18bfd91dd04e1b759cad18d1a338188c936e92f921c7e2
PYTHON_REFERENCING_SETUP_TYPE = pep517
PYTHON_REFERENCING_LICENSE = MIT
PYTHON_REFERENCING_LICENSE_FILES = COPYING
PYTHON_REFERENCING_DEPENDENCIES = host-python-hatch-vcs

HOST_PYTHON_REFERENCING_DEPENDENCIES = host-python-hatch-vcs

# This is a runtime dependency, but we don't have the concept of
# runtime dependencies for host packages.
HOST_PYTHON_REFERENCING_DEPENDENCIES += \
	host-python-attrs \
	host-python-rpds-py

$(eval $(python-package))
$(eval $(host-python-package))
