################################################################################
#
# python-tornado
#
################################################################################

PYTHON_TORNADO_VERSION = 6.6
PYTHON_TORNADO_SOURCE = tornado-$(PYTHON_TORNADO_VERSION).tar.gz
PYTHON_TORNADO_SITE = https://files.pythonhosted.org/packages/d0/02/5f549b1ad5da6267ed1e1fac2eef69257b1979cc812497002499b7895ff9
PYTHON_TORNADO_LICENSE = Apache-2.0
PYTHON_TORNADO_LICENSE_FILES = LICENSE
PYTHON_TORNADO_CPE_ID_VENDOR = tornadoweb
PYTHON_TORNADO_CPE_ID_PRODUCT = tornado
PYTHON_TORNADO_SETUP_TYPE = setuptools

$(eval $(python-package))
