################################################################################
#
# python-zipstream-ng
#
################################################################################

PYTHON_ZIPSTREAM_NG_VERSION = 1.7.1
PYTHON_ZIPSTREAM_NG_SOURCE = zipstream-ng-$(PYTHON_ZIPSTREAM_NG_VERSION).tar.gz
PYTHON_ZIPSTREAM_NG_SITE = https://files.pythonhosted.org/packages/74/8c/682c8bb3085d2089e09c0b9393a12721d059dc0009da4e0b6faff6370679
PYTHON_ZIPSTREAM_NG_SETUP_TYPE = setuptools
PYTHON_ZIPSTREAM_NG_LICENSE = LGPL-3.0
PYTHON_ZIPSTREAM_NG_LICENSE_FILES = LICENSE

$(eval $(python-package))
