################################################################################
#
# python-grpclib
#
################################################################################

PYTHON_GRPCLIB_VERSION = 0.4.8
PYTHON_GRPCLIB_SOURCE = grpclib-$(PYTHON_GRPCLIB_VERSION).tar.gz
PYTHON_GRPCLIB_SITE = https://files.pythonhosted.org/packages/19/75/0f0d3524b38b35e5cd07334b754aa9bd0570140ad982131b04ebfa3b0374
PYTHON_GRPCLIB_SETUP_TYPE = setuptools
PYTHON_GRPCLIB_LICENSE = BSD-3-Clause
PYTHON_GRPCLIB_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
