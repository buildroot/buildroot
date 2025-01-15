################################################################################
#
# python-pathvalidate
#
################################################################################

PYTHON_PATHVALIDATE_VERSION = 3.2.3
PYTHON_PATHVALIDATE_SOURCE = pathvalidate-$(PYTHON_PATHVALIDATE_VERSION).tar.gz
PYTHON_PATHVALIDATE_SITE = https://files.pythonhosted.org/packages/92/87/c7a2f51cc62df0495acb0ed2533a7c74cc895e569a1b020ee5f6e9fa4e21
PYTHON_PATHVALIDATE_SETUP_TYPE = setuptools
PYTHON_PATHVALIDATE_LICENSE = MIT
PYTHON_PATHVALIDATE_LICENSE_FILES = LICENSE
PYTHON_PATHVALIDATE_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
