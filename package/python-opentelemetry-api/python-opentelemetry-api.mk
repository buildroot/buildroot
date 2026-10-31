################################################################################
#
# python-opentelemetry-api
#
################################################################################

PYTHON_OPENTELEMETRY_API_VERSION = 1.45.2
PYTHON_OPENTELEMETRY_API_SOURCE = opentelemetry_api-$(PYTHON_OPENTELEMETRY_API_VERSION).tar.gz
PYTHON_OPENTELEMETRY_API_SITE = https://files.pythonhosted.org/packages/19/14/cf3a6b6448849656e1e5f4e2101f3988dc6789724050096aba1bc5ccf592
PYTHON_OPENTELEMETRY_API_SETUP_TYPE = hatch
PYTHON_OPENTELEMETRY_API_LICENSE = Apache-2.0
PYTHON_OPENTELEMETRY_API_LICENSE_FILES = LICENSE

$(eval $(python-package))
