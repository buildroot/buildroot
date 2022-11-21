################################################################################
#
# python-pyroute2
#
################################################################################

PYTHON_PYROUTE2_SITE = $(TOPDIR)/../thirdparty/pyroute2
PYTHON_PYROUTE2_SITE_METHOD = local

PYTHON_PYROUTE2_LICENSE = Apache-2.0 or GPL-2.0+
PYTHON_PYROUTE2_LICENSE_FILES = LICENSE.Apache.v2 LICENSE.GPL.v2 README.license.md
PYTHON_PYROUTE2_SETUP_TYPE = setuptools

$(eval $(python-package))
