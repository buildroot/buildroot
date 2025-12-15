################################################################################
#
# python-referencing
#
################################################################################

PYTHON_REFERENCING_VERSION = 0.37.0
PYTHON_REFERENCING_SOURCE = referencing-$(PYTHON_REFERENCING_VERSION).tar.gz
PYTHON_REFERENCING_SITE = https://files.pythonhosted.org/packages/22/f5/df4e9027acead3ecc63e50fe1e36aca1523e1719559c499951bb4b53188f
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
