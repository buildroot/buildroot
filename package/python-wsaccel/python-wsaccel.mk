################################################################################
#
# python-wsaccel
#
################################################################################

PYTHON_WSACCEL_VERSION = 0.6.7
PYTHON_WSACCEL_SOURCE = wsaccel-$(PYTHON_WSACCEL_VERSION).tar.gz
PYTHON_WSACCEL_SITE = https://files.pythonhosted.org/packages/8b/06/e8f0450952ed1fb4aa2033a30ae5afb59632f5a35d441bcc6801a3aaca47
PYTHON_WSACCEL_LICENSE = Apache-2.0
PYTHON_WSACCEL_LICENSE_FILES = LICENSE
PYTHON_WSACCEL_SETUP_TYPE = setuptools
PYTHON_WSACCEL_BUILD_OPTS = --skip-dependency-check

$(eval $(python-package))
