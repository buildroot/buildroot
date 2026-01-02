################################################################################
#
# python-jaraco-collections
#
################################################################################

PYTHON_JARACO_COLLECTIONS_VERSION = 5.2.1
PYTHON_JARACO_COLLECTIONS_SOURCE = jaraco_collections-$(PYTHON_JARACO_COLLECTIONS_VERSION).tar.gz
PYTHON_JARACO_COLLECTIONS_SITE = https://files.pythonhosted.org/packages/fa/d2/751000cf702676dbb78f97728f4d52b029e817e2b3c94088dfe5c70ff46d
PYTHON_JARACO_COLLECTIONS_SETUP_TYPE = setuptools
PYTHON_JARACO_COLLECTIONS_LICENSE = MIT
PYTHON_JARACO_COLLECTIONS_LICENSE_FILES = LICENSE
PYTHON_JARACO_COLLECTIONS_DEPENDENCIES = \
	host-python-coherent-licensed \
	host-python-setuptools-scm

$(eval $(python-package))
