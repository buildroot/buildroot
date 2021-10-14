################################################################################
#
# python-django-enumfields
#
################################################################################

PYTHON_DJANGO_ENUMFIELDS_VERSION = 2.1.1
PYTHON_DJANGO_ENUMFIELDS_SOURCE = django-enumfields-$(PYTHON_DJANGO_ENUMFIELDS_VERSION).tar.gz
PYTHON_DJANGO_ENUMFIELDS_SITE = https://files.pythonhosted.org/packages/24/a8/aaf2b5ddb697c9bcab53c32cfebe11e536502e07c30646b4756e7214b685
PYTHON_DJANGO_ENUMFIELDS_SETUP_TYPE = setuptools
PYTHON_DJANGO_ENUMFIELDS_LICENSE = MIT
PYTHON_DJANGO_ENUMFIELDS_LICENSE_FILES = LICENSE

$(eval $(python-package))
