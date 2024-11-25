################################################################################
#
# python-pathvalidate
#
################################################################################

PYTHON_PATHVALIDATE_VERSION = 3.2.1
PYTHON_PATHVALIDATE_SOURCE = pathvalidate-$(PYTHON_PATHVALIDATE_VERSION).tar.gz
PYTHON_PATHVALIDATE_SITE = https://files.pythonhosted.org/packages/b4/8c/8713d8dcd8e357b9358695b441ee974580a8addfaea4f01437df07577052
PYTHON_PATHVALIDATE_SETUP_TYPE = setuptools
PYTHON_PATHVALIDATE_LICENSE = MIT
PYTHON_PATHVALIDATE_LICENSE_FILES = LICENSE
PYTHON_PATHVALIDATE_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
