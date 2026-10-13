################################################################################
#
# python-opentelemetry-api
#
################################################################################

PYTHON_OPENTELEMETRY_API_VERSION = 1.45.1
PYTHON_OPENTELEMETRY_API_SOURCE = opentelemetry_api-$(PYTHON_OPENTELEMETRY_API_VERSION).tar.gz
PYTHON_OPENTELEMETRY_API_SITE = https://files.pythonhosted.org/packages/2e/02/6e0ae9cc61bd3169d401077b507b3ebc344745171e1051ab430be012dcd9
PYTHON_OPENTELEMETRY_API_SETUP_TYPE = hatch
PYTHON_OPENTELEMETRY_API_LICENSE = Apache-2.0
PYTHON_OPENTELEMETRY_API_LICENSE_FILES = LICENSE

$(eval $(python-package))
