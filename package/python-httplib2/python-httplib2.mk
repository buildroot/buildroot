################################################################################
#
# python-httplib2
#
################################################################################

PYTHON_HTTPLIB2_VERSION = 0.22.0
PYTHON_HTTPLIB2_SOURCE = httplib2-$(PYTHON_HTTPLIB2_VERSION).tar.gz
PYTHON_HTTPLIB2_SITE = https://files.pythonhosted.org/packages/3d/ad/2371116b22d616c194aa25ec410c9c6c37f23599dcd590502b74db197584
PYTHON_HTTPLIB2_SETUP_TYPE = setuptools
PYTHON_HTTPLIB2_LICENSE = MIT
PYTHON_HTTPLIB2_LICENSE_FILES = LICENSE
PYTHON_HTTPLIB2_CPE_ID_VENDOR = httplib2_project
PYTHON_HTTPLIB2_CPE_ID_PRODUCT = httplib2

$(eval $(python-package))
$(eval $(host-python-package))
