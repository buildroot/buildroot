################################################################################
#
# python-django
#
################################################################################

PYTHON_DJANGO_VERSION = 6.0.3
PYTHON_DJANGO_SOURCE = django-$(PYTHON_DJANGO_VERSION).tar.gz
PYTHON_DJANGO_SITE = https://files.pythonhosted.org/packages/80/e1/894115c6bd70e2c8b66b0c40a3c367d83a5a48c034a4d904d31b62f7c53a
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
