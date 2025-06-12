################################################################################
#
# python-tornado
#
################################################################################

PYTHON_TORNADO_VERSION = 6.5
PYTHON_TORNADO_SOURCE = tornado-$(PYTHON_TORNADO_VERSION).tar.gz
PYTHON_TORNADO_SITE = https://files.pythonhosted.org/packages/63/c4/bb3bd68b1b3cd30abc6411469875e6d32004397ccc4a3230479f86f86a73
PYTHON_TORNADO_LICENSE = Apache-2.0
PYTHON_TORNADO_LICENSE_FILES = LICENSE
PYTHON_TORNADO_CPE_ID_VENDOR = tornadoweb
PYTHON_TORNADO_CPE_ID_PRODUCT = tornado
PYTHON_TORNADO_SETUP_TYPE = setuptools

# 0001-httputil-raise-errors-instead-of-logging-in.patch
PYTHON_TORNADO_IGNORE_CVES += CVE-2025-47287

$(eval $(python-package))
