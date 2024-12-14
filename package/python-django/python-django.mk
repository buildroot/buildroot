################################################################################
#
# python-django
#
################################################################################

PYTHON_DJANGO_VERSION = 5.1.4
PYTHON_DJANGO_SOURCE = Django-$(PYTHON_DJANGO_VERSION).tar.gz
# The official Django site has an unpractical URL
PYTHON_DJANGO_SITE = https://files.pythonhosted.org/packages/d3/e8/536555596dbb79f6e77418aeb40bdc1758c26725aba31919ba449e6d5e6a
PYTHON_DJANGO_LICENSE = BSD-3-Clause
PYTHON_DJANGO_LICENSE_FILES = LICENSE
PYTHON_DJANGO_CPE_ID_VENDOR = djangoproject
PYTHON_DJANGO_CPE_ID_PRODUCT = django
PYTHON_DJANGO_SETUP_TYPE = setuptools
PYTHON_DJANGO_BUILD_OPTS = --skip-dependency-check

$(eval $(python-package))
