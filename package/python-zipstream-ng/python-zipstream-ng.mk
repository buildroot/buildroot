################################################################################
#
# python-zipstream-ng
#
################################################################################

PYTHON_ZIPSTREAM_NG_VERSION = 1.9.3
PYTHON_ZIPSTREAM_NG_SOURCE = zipstream_ng-$(PYTHON_ZIPSTREAM_NG_VERSION).tar.gz
PYTHON_ZIPSTREAM_NG_SITE = https://files.pythonhosted.org/packages/f3/e0/76e5a674b0f6a6b7f90af9b87a92fbe1f2b97da447fb09078bcba6f6a28e
PYTHON_ZIPSTREAM_NG_SETUP_TYPE = hatch
PYTHON_ZIPSTREAM_NG_LICENSE = LGPL-3.0
PYTHON_ZIPSTREAM_NG_LICENSE_FILES = LICENSE

$(eval $(python-package))
