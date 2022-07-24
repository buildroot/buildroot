################################################################################
#
# python-setuptools
#
################################################################################

PYTHON_SETUPTOOLS_VERSION = 63.2.0
PYTHON_SETUPTOOLS_SOURCE = setuptools-$(PYTHON_SETUPTOOLS_VERSION).tar.gz
PYTHON_SETUPTOOLS_SITE = https://files.pythonhosted.org/packages/0a/ba/52611dc8278828eb9ec339e6914a0f865f9e2af967214905927835dfac0a
PYTHON_SETUPTOOLS_LICENSE = MIT
PYTHON_SETUPTOOLS_LICENSE_FILES = LICENSE
PYTHON_SETUPTOOLS_CPE_ID_VENDOR = python
PYTHON_SETUPTOOLS_CPE_ID_PRODUCT = setuptools
PYTHON_SETUPTOOLS_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
