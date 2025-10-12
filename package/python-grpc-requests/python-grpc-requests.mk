################################################################################
#
# python-grpc-requests
#
################################################################################

PYTHON_GRPC_REQUESTS_VERSION = 0.1.21
PYTHON_GRPC_REQUESTS_SOURCE = grpc_requests-$(PYTHON_GRPC_REQUESTS_VERSION).tar.gz
PYTHON_GRPC_REQUESTS_SITE = https://files.pythonhosted.org/packages/97/58/7e2be40bad0964f7d6f1c11f72be941c19575ab426c10e1b97e17aa1e42f
PYTHON_GRPC_REQUESTS_SETUP_TYPE = setuptools
PYTHON_GRPC_REQUESTS_LICENSE = Apache-2.0
PYTHON_GRPC_REQUESTS_LICENSE_FILES = LICENSE

$(eval $(python-package))
