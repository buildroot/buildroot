################################################################################
#
# python-django
#
################################################################################

PYTHON_DJANGO_VERSION = 1.11.20
PYTHON_DJANGO_SOURCE = Django-$(PYTHON_DJANGO_VERSION).tar.gz
# The official Django site has an unpractical URL
PYTHON_DJANGO_SITE = https://files.pythonhosted.org/packages/99/2a/6cb6fdae67a101e19cd02b1af75131eee51b8dcd0cc22c9cfdd2270b5715

PYTHON_DJANGO_LICENSE = BSD-3-Clause
PYTHON_DJANGO_LICENSE_FILES = LICENSE
PYTHON_DJANGO_SETUP_TYPE = setuptools

$(eval $(python-package))
