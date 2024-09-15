################################################################################
#
# python-grpc-requests
#
################################################################################

PYTHON_GRPC_REQUESTS_VERSION = 0.1.20
PYTHON_GRPC_REQUESTS_SOURCE = grpc_requests-$(PYTHON_GRPC_REQUESTS_VERSION).tar.gz
PYTHON_GRPC_REQUESTS_SITE = https://files.pythonhosted.org/packages/92/84/f5a3874a6e10448d8c198253d2c79f7b34a23fb4a96b78a648dc468913a6
PYTHON_GRPC_REQUESTS_SETUP_TYPE = setuptools
PYTHON_GRPC_REQUESTS_LICENSE = Apache-2.0
PYTHON_GRPC_REQUESTS_LICENSE_FILES = LICENSE

$(eval $(python-package))
