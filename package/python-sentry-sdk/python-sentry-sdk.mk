################################################################################
#
# python-sentry-sdk
#
################################################################################

PYTHON_SENTRY_SDK_VERSION = 2.54.0
PYTHON_SENTRY_SDK_SOURCE = sentry_sdk-$(PYTHON_SENTRY_SDK_VERSION).tar.gz
PYTHON_SENTRY_SDK_SITE = https://files.pythonhosted.org/packages/c8/e9/2e3a46c304e7fa21eaa70612f60354e32699c7102eb961f67448e222ad7c
PYTHON_SENTRY_SDK_SETUP_TYPE = setuptools
PYTHON_SENTRY_SDK_LICENSE = MIT
PYTHON_SENTRY_SDK_LICENSE_FILES = LICENSE

$(eval $(python-package))
