################################################################################
#
# python-grpclib
#
################################################################################

PYTHON_GRPCLIB_VERSION = 0.4.9
PYTHON_GRPCLIB_SOURCE = grpclib-$(PYTHON_GRPCLIB_VERSION).tar.gz
PYTHON_GRPCLIB_SITE = https://files.pythonhosted.org/packages/5b/28/5a2c299ec82a876a252c5919aa895a6f1d1d35c96417c5ce4a4660dc3a80
PYTHON_GRPCLIB_SETUP_TYPE = setuptools
PYTHON_GRPCLIB_LICENSE = BSD-3-Clause
PYTHON_GRPCLIB_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
