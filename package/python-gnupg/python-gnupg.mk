################################################################################
#
# python-gnupg
#
################################################################################

PYTHON_GNUPG_VERSION = 0.5.7
PYTHON_GNUPG_SOURCE = python_gnupg-$(PYTHON_GNUPG_VERSION).tar.gz
PYTHON_GNUPG_SITE = https://files.pythonhosted.org/packages/bb/d4/47aa0f34b6a06a976063e3e0bf1512b140ec1e6efda83bc717fac58071db
PYTHON_GNUPG_LICENSE = BSD-3-Clause
PYTHON_GNUPG_LICENSE_FILES = LICENSE.txt
PYTHON_GNUPG_CPE_ID_VENDOR = python
PYTHON_GNUPG_SETUP_TYPE = setuptools
PYTHON_GNUPG_BUILD_OPTS = --skip-dependency-check

$(eval $(python-package))
