################################################################################
#
# python-django
#
################################################################################

PYTHON_DJANGO_VERSION = 1.11.18
PYTHON_DJANGO_SOURCE = Django-$(PYTHON_DJANGO_VERSION).tar.gz
# The official Django site has an unpractical URL
PYTHON_DJANGO_SITE = https://files.pythonhosted.org/packages/90/84/7981bdfcfa80fe81df5325899f9fc1cbebce1fbe4fac092a32dca00d0ab2
PYTHON_DJANGO_LICENSE = BSD-3-Clause
PYTHON_DJANGO_LICENSE_FILES = LICENSE
PYTHON_DJANGO_SETUP_TYPE = setuptools

$(eval $(python-package))
