################################################################################
#
# python-jaraco-collections
#
################################################################################

PYTHON_JARACO_COLLECTIONS_VERSION = 5.0.0
PYTHON_JARACO_COLLECTIONS_SOURCE = jaraco.collections-$(PYTHON_JARACO_COLLECTIONS_VERSION).tar.gz
PYTHON_JARACO_COLLECTIONS_SITE = https://files.pythonhosted.org/packages/e6/85/9c4ab9772bcc2c9b4beffd56aca70f646e4a1f3a576579fa401d742b46a8
PYTHON_JARACO_COLLECTIONS_SETUP_TYPE = setuptools
PYTHON_JARACO_COLLECTIONS_LICENSE = MIT
PYTHON_JARACO_COLLECTIONS_LICENSE_FILES = LICENSE
PYTHON_JARACO_COLLECTIONS_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
