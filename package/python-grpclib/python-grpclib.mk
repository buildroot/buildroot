################################################################################
#
# python-grpclib
#
################################################################################

PYTHON_GRPCLIB_VERSION = 0.4.7
PYTHON_GRPCLIB_SOURCE = grpclib-$(PYTHON_GRPCLIB_VERSION).tar.gz
PYTHON_GRPCLIB_SITE = https://files.pythonhosted.org/packages/79/b9/55936e462a5925190d7427e880b3033601d1effd13809b483d13a926061a
PYTHON_GRPCLIB_SETUP_TYPE = setuptools
PYTHON_GRPCLIB_LICENSE = BSD-3-Clause
PYTHON_GRPCLIB_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
