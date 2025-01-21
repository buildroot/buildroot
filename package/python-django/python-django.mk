################################################################################
#
# python-django
#
################################################################################

PYTHON_DJANGO_VERSION = 5.1.5
PYTHON_DJANGO_SOURCE = Django-$(PYTHON_DJANGO_VERSION).tar.gz
# The official Django site has an unpractical URL
PYTHON_DJANGO_SITE = https://files.pythonhosted.org/packages/e4/17/834e3e08d590dcc27d4cc3c5cd4e2fb757b7a92bab9de8ee402455732952
PYTHON_DJANGO_LICENSE = BSD-3-Clause
PYTHON_DJANGO_LICENSE_FILES = LICENSE
PYTHON_DJANGO_CPE_ID_VENDOR = djangoproject
PYTHON_DJANGO_CPE_ID_PRODUCT = django
PYTHON_DJANGO_SETUP_TYPE = setuptools
PYTHON_DJANGO_BUILD_OPTS = --skip-dependency-check

$(eval $(python-package))
