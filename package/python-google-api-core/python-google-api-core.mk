################################################################################
#
# python-google-api-core
#
################################################################################

PYTHON_GOOGLE_API_CORE_VERSION = 2.44.0
PYTHON_GOOGLE_API_CORE_SOURCE = google_api_core-$(PYTHON_GOOGLE_API_CORE_VERSION).tar.gz
PYTHON_GOOGLE_API_CORE_SITE = https://files.pythonhosted.org/packages/72/ef/63d89cb580f3a42c51db53b3d151352aa61b9c87ea8cfdd8d24ee6caa09d
PYTHON_GOOGLE_API_CORE_SETUP_TYPE = setuptools
PYTHON_GOOGLE_API_CORE_LICENSE = Apache-2.0
PYTHON_GOOGLE_API_CORE_LICENSE_FILES = LICENSE

$(eval $(python-package))
