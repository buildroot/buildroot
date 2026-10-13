################################################################################
#
# python-google-api-core
#
################################################################################

PYTHON_GOOGLE_API_CORE_VERSION = 2.42.0
PYTHON_GOOGLE_API_CORE_SOURCE = google_api_core-$(PYTHON_GOOGLE_API_CORE_VERSION).tar.gz
PYTHON_GOOGLE_API_CORE_SITE = https://files.pythonhosted.org/packages/ac/aa/2aa84799e6920216f8aa2866d3b43daa20f7060dcb6efc8f0449e8be0ab0
PYTHON_GOOGLE_API_CORE_SETUP_TYPE = setuptools
PYTHON_GOOGLE_API_CORE_LICENSE = Apache-2.0
PYTHON_GOOGLE_API_CORE_LICENSE_FILES = LICENSE

$(eval $(python-package))
