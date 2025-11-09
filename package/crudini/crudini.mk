################################################################################
#
# crudini
#
################################################################################

CRUDINI_VERSION = 0.9.6
CRUDINI_SITE = https://files.pythonhosted.org/packages/54/d1/0a363fbbab0aea9e27dd981a602efaf514c45f4fffceac3906274e0425c7
CRUDINI_SETUP_TYPE = setuptools
CRUDINI_DEPENDENCIES = host-python-setuptools-scm
CRUDINI_LICENSE = GPL-2.0
CRUDINI_LICENSE_FILES = COPYING
# This is a runtime dependency, but we don't have the concept of
# runtime dependencies for host packages.
HOST_CRUDINI_DEPENDENCIES = host-python-iniparse host-python-setuptools-scm

$(eval $(python-package))
$(eval $(host-python-package))
