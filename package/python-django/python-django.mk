################################################################################
#
# python-django
#
################################################################################

PYTHON_DJANGO_VERSION = 5.1.9
PYTHON_DJANGO_SOURCE = django-$(PYTHON_DJANGO_VERSION).tar.gz
# The official Django site has an unpractical URL
PYTHON_DJANGO_SITE = https://files.pythonhosted.org/packages/10/08/2e6f05494b3fc0a3c53736846034f882b82ee6351791a7815bbb45715d79
PYTHON_DJANGO_LICENSE = BSD-3-Clause
PYTHON_DJANGO_LICENSE_FILES = LICENSE
PYTHON_DJANGO_CPE_ID_VENDOR = djangoproject
PYTHON_DJANGO_CPE_ID_PRODUCT = django
PYTHON_DJANGO_SETUP_TYPE = setuptools

$(eval $(python-package))
