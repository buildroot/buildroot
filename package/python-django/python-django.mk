################################################################################
#
# python-django
#
################################################################################

PYTHON_DJANGO_VERSION = 2.2.11
PYTHON_DJANGO_SOURCE = Django-$(PYTHON_DJANGO_VERSION).tar.gz
# The official Django site has an unpractical URL
PYTHON_DJANGO_SITE = https://files.pythonhosted.org/packages/f0/5b/428db83c37c2cf69e077ed327ada3511837371356204befc654b5b4bd444
PYTHON_DJANGO_LICENSE = BSD-3-Clause
PYTHON_DJANGO_LICENSE_FILES = LICENSE
PYTHON_DJANGO_SETUP_TYPE = setuptools

$(eval $(python-package))
