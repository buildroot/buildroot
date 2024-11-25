################################################################################
#
# python-sentry-sdk
#
################################################################################

PYTHON_SENTRY_SDK_VERSION = 2.18.0
PYTHON_SENTRY_SDK_SOURCE = sentry_sdk-$(PYTHON_SENTRY_SDK_VERSION).tar.gz
PYTHON_SENTRY_SDK_SITE = https://files.pythonhosted.org/packages/24/cc/0d87cc8246f52d92228aa6718a24e1988a2893f4abe2f64ec5a8bcba4185
PYTHON_SENTRY_SDK_SETUP_TYPE = setuptools
PYTHON_SENTRY_SDK_LICENSE = MIT
PYTHON_SENTRY_SDK_LICENSE_FILES = LICENSE

$(eval $(python-package))
