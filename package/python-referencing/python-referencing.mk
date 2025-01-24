################################################################################
#
# python-referencing
#
################################################################################

PYTHON_REFERENCING_VERSION = 0.36.1
PYTHON_REFERENCING_SOURCE = referencing-$(PYTHON_REFERENCING_VERSION).tar.gz
PYTHON_REFERENCING_SITE = https://files.pythonhosted.org/packages/27/32/fd98246df7a0f309b58cae68b10b6b219ef2eb66747f00dfb34422687087
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
