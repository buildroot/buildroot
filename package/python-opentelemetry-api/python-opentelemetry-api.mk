################################################################################
#
# python-opentelemetry-api
#
################################################################################

PYTHON_OPENTELEMETRY_API_VERSION = 1.45.0
PYTHON_OPENTELEMETRY_API_SOURCE = opentelemetry_api-$(PYTHON_OPENTELEMETRY_API_VERSION).tar.gz
PYTHON_OPENTELEMETRY_API_SITE = https://files.pythonhosted.org/packages/1f/dc/e12c1fe1ed8a7b7149777127b1a0e12ce5bd5a81d97408bedc2128c260f5
PYTHON_OPENTELEMETRY_API_SETUP_TYPE = hatch
PYTHON_OPENTELEMETRY_API_LICENSE = Apache-2.0
PYTHON_OPENTELEMETRY_API_LICENSE_FILES = LICENSE

$(eval $(python-package))
