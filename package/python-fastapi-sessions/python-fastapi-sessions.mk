################################################################################
#
# python-fastapi-sessions
#
################################################################################

PYTHON_FASTAPI_SESSIONS_VERSION = 0.3.2
PYTHON_FASTAPI_SESSIONS_SOURCE = fastapi-sessions-$(PYTHON_FASTAPI_SESSIONS_VERSION).tar.gz
PYTHON_FASTAPI_SESSIONS_SITE = https://files.pythonhosted.org/packages/1d/89/da83ba47bd70101e14eca0ac57c7f300b055b70104446badfdc1dcbe813f
PYTHON_FASTAPI_SESSIONS_SETUP_TYPE = setuptools
PYTHON_FASTAPI_SESSIONS_LICENSE = MIT
PYTHON_FASTAPI_SESSIONS_LICENSE_FILES = LICENSE

$(eval $(python-package))
