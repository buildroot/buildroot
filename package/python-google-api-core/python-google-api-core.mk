################################################################################
#
# python-google-api-core
#
################################################################################

PYTHON_GOOGLE_API_CORE_VERSION = 2.30.0
PYTHON_GOOGLE_API_CORE_SOURCE = google_api_core-$(PYTHON_GOOGLE_API_CORE_VERSION).tar.gz
PYTHON_GOOGLE_API_CORE_SITE = https://files.pythonhosted.org/packages/22/98/586ec94553b569080caef635f98a3723db36a38eac0e3d7eb3ea9d2e4b9a
PYTHON_GOOGLE_API_CORE_SETUP_TYPE = setuptools
PYTHON_GOOGLE_API_CORE_LICENSE = Apache-2.0
PYTHON_GOOGLE_API_CORE_LICENSE_FILES = LICENSE

$(eval $(python-package))
