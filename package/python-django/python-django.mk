################################################################################
#
# python-django
#
################################################################################

PYTHON_DJANGO_VERSION = 2.1.11
PYTHON_DJANGO_SOURCE = Django-$(PYTHON_DJANGO_VERSION).tar.gz
# The official Django site has an unpractical URL
PYTHON_DJANGO_SITE = https://files.pythonhosted.org/packages/e0/e9/7e6008abee3eb2a40704c95a5cfc8a9627012df1580289d3df0f34c99766
PYTHON_DJANGO_LICENSE = BSD-3-Clause
PYTHON_DJANGO_LICENSE_FILES = LICENSE
PYTHON_DJANGO_SETUP_TYPE = setuptools

$(eval $(python-package))
