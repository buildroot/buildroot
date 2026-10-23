################################################################################
#
# python-sentry-sdk
#
################################################################################

PYTHON_SENTRY_SDK_VERSION = 2.73.0
PYTHON_SENTRY_SDK_SOURCE = sentry_sdk-$(PYTHON_SENTRY_SDK_VERSION).tar.gz
PYTHON_SENTRY_SDK_SITE = https://files.pythonhosted.org/packages/c5/3b/1e47acf2456781c26e12007379ecc154bf310b8f64d40390d78b791d55c3
PYTHON_SENTRY_SDK_SETUP_TYPE = setuptools
PYTHON_SENTRY_SDK_LICENSE = MIT
PYTHON_SENTRY_SDK_LICENSE_FILES = LICENSE

$(eval $(python-package))
