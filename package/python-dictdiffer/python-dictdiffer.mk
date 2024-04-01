################################################################################
#
# python-dictdiffer
#
################################################################################

PYTHON_DICTDIFFER_VERSION = 0.9.0
PYTHON_DICTDIFFER_SOURCE = dictdiffer-$(PYTHON_DICTDIFFER_VERSION).tar.gz
PYTHON_DICTDIFFER_SITE = https://files.pythonhosted.org/packages/61/7b/35cbccb7effc5d7e40f4c55e2b79399e1853041997fcda15c9ff160abba0
PYTHON_DICTDIFFER_SETUP_TYPE = setuptools
PYTHON_DICTDIFFER_LICENSE = MIT
PYTHON_DICTDIFFER_LICENSE_FILES = LICENSE
PYTHON_DICTDIFFER_DEPENDENCIES = host-python-setuptools-scm
PYTHON_DICTDIFFER_BUILD_OPTS = --skip-dependency-check

$(eval $(python-package))
