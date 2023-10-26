################################################################################
#
# python-wsaccel
#
################################################################################

PYTHON_WSACCEL_VERSION = 0.6.6
PYTHON_WSACCEL_SOURCE = wsaccel-$(PYTHON_WSACCEL_VERSION).tar.gz
PYTHON_WSACCEL_SITE = https://files.pythonhosted.org/packages/94/28/41c0e711b538f6031a247ab4ec5352267f12ed416e3a638b8d55fc33f609
PYTHON_WSACCEL_LICENSE = Apache-2.0
PYTHON_WSACCEL_LICENSE_FILES = LICENSE
PYTHON_WSACCEL_SETUP_TYPE = setuptools

$(eval $(python-package))
