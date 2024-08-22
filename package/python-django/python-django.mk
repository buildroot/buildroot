################################################################################
#
# python-django
#
################################################################################

PYTHON_DJANGO_VERSION = 5.1
PYTHON_DJANGO_SOURCE = Django-$(PYTHON_DJANGO_VERSION).tar.gz
# The official Django site has an unpractical URL
PYTHON_DJANGO_SITE = https://files.pythonhosted.org/packages/1e/0c/d854d25bb74a8a3b41e642bbd27fe6af12fadd0edfd07d487809cf0ef719
PYTHON_DJANGO_LICENSE = BSD-3-Clause
PYTHON_DJANGO_LICENSE_FILES = LICENSE
PYTHON_DJANGO_CPE_ID_VENDOR = djangoproject
PYTHON_DJANGO_CPE_ID_PRODUCT = django
PYTHON_DJANGO_SETUP_TYPE = setuptools
PYTHON_DJANGO_BUILD_OPTS = --skip-dependency-check

$(eval $(python-package))
