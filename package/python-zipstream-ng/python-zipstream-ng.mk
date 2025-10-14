################################################################################
#
# python-zipstream-ng
#
################################################################################

PYTHON_ZIPSTREAM_NG_VERSION = 1.9.0
PYTHON_ZIPSTREAM_NG_SOURCE = zipstream_ng-$(PYTHON_ZIPSTREAM_NG_VERSION).tar.gz
PYTHON_ZIPSTREAM_NG_SITE = https://files.pythonhosted.org/packages/11/f2/690a35762cf8366ce6f3b644805de970bd6a897ca44ce74184c7b2bc94e7
PYTHON_ZIPSTREAM_NG_SETUP_TYPE = setuptools
PYTHON_ZIPSTREAM_NG_LICENSE = LGPL-3.0
PYTHON_ZIPSTREAM_NG_LICENSE_FILES = LICENSE

$(eval $(python-package))
