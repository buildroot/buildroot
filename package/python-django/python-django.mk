################################################################################
#
# python-django
#
################################################################################

PYTHON_DJANGO_VERSION = 5.1.1
PYTHON_DJANGO_SOURCE = Django-$(PYTHON_DJANGO_VERSION).tar.gz
# The official Django site has an unpractical URL
PYTHON_DJANGO_SITE = https://files.pythonhosted.org/packages/88/6f/8f57ed6dc88656edd4fcb35c50dd963f3cd79303bd711fb0160fc7fd6ab7
PYTHON_DJANGO_LICENSE = BSD-3-Clause
PYTHON_DJANGO_LICENSE_FILES = LICENSE
PYTHON_DJANGO_CPE_ID_VENDOR = djangoproject
PYTHON_DJANGO_CPE_ID_PRODUCT = django
PYTHON_DJANGO_SETUP_TYPE = setuptools
PYTHON_DJANGO_BUILD_OPTS = --skip-dependency-check

$(eval $(python-package))
