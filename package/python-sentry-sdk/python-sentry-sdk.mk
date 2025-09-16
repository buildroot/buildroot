################################################################################
#
# python-sentry-sdk
#
################################################################################

PYTHON_SENTRY_SDK_VERSION = 2.38.0
PYTHON_SENTRY_SDK_SOURCE = sentry_sdk-$(PYTHON_SENTRY_SDK_VERSION).tar.gz
PYTHON_SENTRY_SDK_SITE = https://files.pythonhosted.org/packages/b2/22/60fd703b34d94d216b2387e048ac82de3e86b63bc28869fb076f8bb0204a
PYTHON_SENTRY_SDK_SETUP_TYPE = setuptools
PYTHON_SENTRY_SDK_LICENSE = MIT
PYTHON_SENTRY_SDK_LICENSE_FILES = LICENSE

$(eval $(python-package))
