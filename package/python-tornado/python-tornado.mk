################################################################################
#
# python-tornado
#
################################################################################

PYTHON_TORNADO_VERSION = 6.2
PYTHON_TORNADO_SOURCE = tornado-$(PYTHON_TORNADO_VERSION).tar.gz
PYTHON_TORNADO_SITE = https://files.pythonhosted.org/packages/f3/9e/225a41452f2d9418d89be5e32cf824c84fe1e639d350d6e8d49db5b7f73a
PYTHON_TORNADO_LICENSE = Apache-2.0
PYTHON_TORNADO_LICENSE_FILES = LICENSE
PYTHON_TORNADO_CPE_ID_VENDOR = tornadoweb
PYTHON_TORNADO_CPE_ID_PRODUCT = tornado
PYTHON_TORNADO_SETUP_TYPE = setuptools
# 0001-web-Fix-an-open-redirect-in-StaticFileHandler.patch
PYTHON_TORNADO_IGNORE_CVES += CVE-2023-28370

$(eval $(python-package))
