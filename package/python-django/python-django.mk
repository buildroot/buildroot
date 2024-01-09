################################################################################
#
# python-django
#
################################################################################

PYTHON_DJANGO_VERSION = 5.0.1
PYTHON_DJANGO_SOURCE = Django-$(PYTHON_DJANGO_VERSION).tar.gz
# The official Django site has an unpractical URL
PYTHON_DJANGO_SITE = https://files.pythonhosted.org/packages/53/82/c8e8ed137da1c72fa110e3be9ab0f26bcfcf6f3d2994601d164dfac86269
PYTHON_DJANGO_LICENSE = BSD-3-Clause
PYTHON_DJANGO_LICENSE_FILES = LICENSE
PYTHON_DJANGO_CPE_ID_VENDOR = djangoproject
PYTHON_DJANGO_CPE_ID_PRODUCT = django
PYTHON_DJANGO_SETUP_TYPE = setuptools

$(eval $(python-package))
