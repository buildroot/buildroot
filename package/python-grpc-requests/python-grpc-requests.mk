################################################################################
#
# python-grpc-requests
#
################################################################################

PYTHON_GRPC_REQUESTS_VERSION = 0.1.13
PYTHON_GRPC_REQUESTS_SOURCE = grpc_requests-$(PYTHON_GRPC_REQUESTS_VERSION).tar.gz
PYTHON_GRPC_REQUESTS_SITE = https://files.pythonhosted.org/packages/46/51/8981bce4ca61bce1c7b7a12dd04f6cbd35c4ea874842b06283f6bbc9a0e8
PYTHON_GRPC_REQUESTS_SETUP_TYPE = setuptools
PYTHON_GRPC_REQUESTS_LICENSE = Apache-2.0
PYTHON_GRPC_REQUESTS_LICENSE_FILES = LICENSE

$(eval $(python-package))
