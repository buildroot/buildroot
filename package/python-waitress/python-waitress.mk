################################################################################
#
# python-waitress
#
################################################################################

PYTHON_WAITRESS_VERSION = 3.0.0
PYTHON_WAITRESS_SOURCE = waitress-$(PYTHON_WAITRESS_VERSION).tar.gz
PYTHON_WAITRESS_SITE = https://files.pythonhosted.org/packages/70/34/cb77e5249c433eb177a11ab7425056b32d3b57855377fa1e38b397412859
PYTHON_WAITRESS_SETUP_TYPE = setuptools
PYTHON_WAITRESS_LICENSE = ZPL-2.1
PYTHON_WAITRESS_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
