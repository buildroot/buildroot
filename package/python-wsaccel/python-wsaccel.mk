################################################################################
#
# python-wsaccel
#
################################################################################

PYTHON_WSACCEL_VERSION = 0.6.4
PYTHON_WSACCEL_SOURCE = wsaccel-$(PYTHON_WSACCEL_VERSION).tar.gz
PYTHON_WSACCEL_SITE = https://files.pythonhosted.org/packages/77/0b/a44df15382a76b6768184630d483b8363d65b9f70d1aacf76153d496bbb9
PYTHON_WSACCEL_LICENSE = Apache-2.0
PYTHON_WSACCEL_LICENSE_FILES = LICENSE
PYTHON_WSACCEL_SETUP_TYPE = setuptools

$(eval $(python-package))
