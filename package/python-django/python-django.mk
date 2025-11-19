################################################################################
#
# python-django
#
################################################################################

PYTHON_DJANGO_VERSION = 5.1.14
PYTHON_DJANGO_SOURCE = django-$(PYTHON_DJANGO_VERSION).tar.gz
# The official Django site has an unpractical URL
PYTHON_DJANGO_SITE = https://files.pythonhosted.org/packages/6e/f9/284077f0e61f633e5279518a9ac5924ade4bef12bc841174ca48c57f2438
PYTHON_DJANGO_LICENSE = BSD-3-Clause, MIT (jquery, utils/archive.py), BSD-2-Clause (inlines.js)
PYTHON_DJANGO_LICENSE_FILES = LICENSE \
	django/contrib/gis/measure.py \
	django/contrib/gis/gdal/LICENSE \
	django/contrib/gis/geos/LICENSE \
	django/contrib/admin/static/admin/js/inlines.js \
	django/contrib/admin/static/admin/js/vendor/jquery/LICENSE.txt \
	django/contrib/admin/static/admin/js/vendor/select2/LICENSE.md \
	django/contrib/admin/static/admin/js/vendor/xregexp/LICENSE.txt \
	django/contrib/admin/static/admin/img/LICENSE \
	django/dispatch/license.txt \
	django/utils/archive.py
PYTHON_DJANGO_CPE_ID_VENDOR = djangoproject
PYTHON_DJANGO_CPE_ID_PRODUCT = django
PYTHON_DJANGO_SETUP_TYPE = setuptools

$(eval $(python-package))
