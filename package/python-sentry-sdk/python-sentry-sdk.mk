################################################################################
#
# python-sentry-sdk
#
################################################################################

PYTHON_SENTRY_SDK_VERSION = 1.4.3
PYTHON_SENTRY_SDK_SOURCE = sentry-sdk-$(PYTHON_SENTRY_SDK_VERSION).tar.gz
PYTHON_SENTRY_SDK_SITE = https://files.pythonhosted.org/packages/a7/30/1d967b2e0cac2fa388344b2968fa57e69d5382b922e57cda43af54b9063a
PYTHON_SENTRY_SDK_SETUP_TYPE = setuptools
PYTHON_SENTRY_SDK_LICENSE = BSD-2-Clause
PYTHON_SENTRY_SDK_LICENSE_FILES = LICENSE

$(eval $(python-package))
