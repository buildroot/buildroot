################################################################################
#
# python-google-api-core
#
################################################################################

PYTHON_GOOGLE_API_CORE_VERSION = 2.15.0
PYTHON_GOOGLE_API_CORE_SOURCE = google-api-core-$(PYTHON_GOOGLE_API_CORE_VERSION).tar.gz
PYTHON_GOOGLE_API_CORE_SITE = https://files.pythonhosted.org/packages/2c/e4/56b14d35057a23cab9067dd8fb841407d05d32b5d6c7a3c66c1360e8a7c0
PYTHON_GOOGLE_API_CORE_SETUP_TYPE = setuptools
PYTHON_GOOGLE_API_CORE_LICENSE = Apache-2.0
PYTHON_GOOGLE_API_CORE_LICENSE_FILES = LICENSE

$(eval $(python-package))
