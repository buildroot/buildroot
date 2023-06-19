################################################################################
#
# python-django
#
################################################################################

PYTHON_DJANGO_VERSION = 4.1.9
PYTHON_DJANGO_SOURCE = Django-$(PYTHON_DJANGO_VERSION).tar.gz
# The official Django site has an unpractical URL
PYTHON_DJANGO_SITE = https://files.pythonhosted.org/packages/11/ea/8b514434c57c3bef89a475b75f74d768471d8e1bc61f4e5c79daeae9b5ef

PYTHON_DJANGO_LICENSE = BSD-3-Clause
PYTHON_DJANGO_LICENSE_FILES = LICENSE
PYTHON_DJANGO_CPE_ID_VENDOR = djangoproject
PYTHON_DJANGO_CPE_ID_PRODUCT = django
PYTHON_DJANGO_SETUP_TYPE = setuptools

$(eval $(python-package))
