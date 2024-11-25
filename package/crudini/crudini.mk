################################################################################
#
# crudini
#
################################################################################

CRUDINI_VERSION = 0.9.5
CRUDINI_SITE = https://files.pythonhosted.org/packages/32/67/c4e838930e2f434db08d6a6aadffca3d14e7455d1c2c2332e22003ad453d
CRUDINI_SETUP_TYPE = setuptools
CRUDINI_DEPENDENCIES = host-python-setuptools-scm
CRUDINI_LICENSE = GPL-2.0
CRUDINI_LICENSE_FILES = COPYING
# This is a runtime dependency, but we don't have the concept of
# runtime dependencies for host packages.
HOST_CRUDINI_DEPENDENCIES = host-python-iniparse host-python-setuptools-scm

$(eval $(python-package))
$(eval $(host-python-package))
