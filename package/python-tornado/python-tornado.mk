################################################################################
#
# python-tornado
#
################################################################################

PYTHON_TORNADO_VERSION = 6.4.1
PYTHON_TORNADO_SOURCE = tornado-$(PYTHON_TORNADO_VERSION).tar.gz
PYTHON_TORNADO_SITE = https://files.pythonhosted.org/packages/ee/66/398ac7167f1c7835406888a386f6d0d26ee5dbf197d8a571300be57662d3
PYTHON_TORNADO_LICENSE = Apache-2.0
PYTHON_TORNADO_LICENSE_FILES = LICENSE
PYTHON_TORNADO_CPE_ID_VENDOR = tornadoweb
PYTHON_TORNADO_CPE_ID_PRODUCT = tornado
PYTHON_TORNADO_SETUP_TYPE = setuptools

$(eval $(python-package))
