################################################################################
#
# python-django
#
################################################################################

PYTHON_DJANGO_VERSION = 3.0.7
PYTHON_DJANGO_SOURCE = Django-$(PYTHON_DJANGO_VERSION).tar.gz
# The official Django site has an unpractical URL
PYTHON_DJANGO_SITE = https://files.pythonhosted.org/packages/74/ad/8a1bc5e0f8b740792c99c7bef5ecc043018e2b605a2fe1e2513fde586b72
PYTHON_DJANGO_LICENSE = BSD-3-Clause
PYTHON_DJANGO_LICENSE_FILES = LICENSE
PYTHON_DJANGO_SETUP_TYPE = setuptools

$(eval $(python-package))
