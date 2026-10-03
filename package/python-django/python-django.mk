################################################################################
#
# python-django
#
################################################################################

PYTHON_DJANGO_VERSION = 6.1.1
PYTHON_DJANGO_SOURCE = django-$(PYTHON_DJANGO_VERSION).tar.gz
PYTHON_DJANGO_SITE = https://files.pythonhosted.org/packages/f8/d4/8314b5bdef20832f0ac6ae3b3e4d4924e4759fa3b4af27609dd747e7a6be
PYTHON_DJANGO_LICENSE = BSD-3-Clause, MIT (jquery, utils/archive.py), BSD-2-Clause (inlines.js), CC-BY-4.0 (admin svg files)
PYTHON_DJANGO_LICENSE_FILES = LICENSE \
	django/contrib/gis/measure.py \
	django/contrib/gis/gdal/LICENSE \
	django/contrib/gis/geos/LICENSE \
	django/contrib/admin/static/admin/js/inlines.js \
	django/contrib/admin/static/admin/js/vendor/jquery/LICENSE.txt \
	django/contrib/admin/static/admin/js/vendor/select2/LICENSE.md \
	django/contrib/admin/static/admin/js/vendor/xregexp/LICENSE.txt \
	django/contrib/admin/static/admin/img/README.md \
	django/dispatch/license.txt \
	django/utils/archive.py
PYTHON_DJANGO_CPE_ID_VENDOR = djangoproject
PYTHON_DJANGO_CPE_ID_PRODUCT = django
PYTHON_DJANGO_SETUP_TYPE = setuptools

$(eval $(python-package))
