################################################################################
#
# python-jaraco-collections
#
################################################################################

PYTHON_JARACO_COLLECTIONS_VERSION = 5.1.0
PYTHON_JARACO_COLLECTIONS_SOURCE = jaraco_collections-$(PYTHON_JARACO_COLLECTIONS_VERSION).tar.gz
PYTHON_JARACO_COLLECTIONS_SITE = https://files.pythonhosted.org/packages/8c/ed/3f0ef2bcf765b5a3d58ecad8d825874a3af1e792fa89f89ad79f090a4ccc
PYTHON_JARACO_COLLECTIONS_SETUP_TYPE = setuptools
PYTHON_JARACO_COLLECTIONS_LICENSE = MIT
PYTHON_JARACO_COLLECTIONS_LICENSE_FILES = LICENSE
PYTHON_JARACO_COLLECTIONS_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
