################################################################################
#
# python-sentry-sdk
#
################################################################################

PYTHON_SENTRY_SDK_VERSION = 0.14.4
PYTHON_SENTRY_SDK_SOURCE = sentry-sdk-$(PYTHON_SENTRY_SDK_VERSION).tar.gz
PYTHON_SENTRY_SDK_SITE = https://files.pythonhosted.org/packages/ab/67/b653a44ce124a2b700a7fc349ca129282c5fec4fdc9197f558178a9e32ae
PYTHON_SENTRY_SDK_SETUP_TYPE = setuptools
PYTHON_SENTRY_SDK_LICENSE = BSD-2-Clause
PYTHON_SENTRY_SDK_LICENSE_FILES = LICENSE

ifeq ($(BR2_PACKAGE_PYTHON),y)
# only needed/valid for python 3.x
define PYTHON_SENTRY_SDK_RM_PY3_FILES
	rm -f $(addprefix $(TARGET_DIR)/usr/lib/python*/site-packages/sentry_sdk/integrations/,\
		aiohttp.py asgi.py django/asgi.py sanic.py tornado.py)
endef

PYTHON_SENTRY_SDK_POST_INSTALL_TARGET_HOOKS += PYTHON_SENTRY_SDK_RM_PY3_FILES
endif

$(eval $(python-package))
