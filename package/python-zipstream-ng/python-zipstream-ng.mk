################################################################################
#
# python-zipstream-ng
#
################################################################################

PYTHON_ZIPSTREAM_NG_VERSION = 1.8.0
PYTHON_ZIPSTREAM_NG_SOURCE = zipstream_ng-$(PYTHON_ZIPSTREAM_NG_VERSION).tar.gz
PYTHON_ZIPSTREAM_NG_SITE = https://files.pythonhosted.org/packages/ac/16/5d9224baf640214255c34a0a0e9528c8403d2b89e2ba7df9d7cada58beb1
PYTHON_ZIPSTREAM_NG_SETUP_TYPE = setuptools
PYTHON_ZIPSTREAM_NG_LICENSE = LGPL-3.0
PYTHON_ZIPSTREAM_NG_LICENSE_FILES = LICENSE

$(eval $(python-package))
