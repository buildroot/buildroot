################################################################################
#
# python-pyasn1
#
################################################################################

PYTHON_PYASN1_VERSION = 0.6.3
PYTHON_PYASN1_SOURCE = pyasn1-$(PYTHON_PYASN1_VERSION).tar.gz
PYTHON_PYASN1_SITE = https://files.pythonhosted.org/packages/5c/5f/6583902b6f79b399c9c40674ac384fd9cd77805f9e6205075f828ef11fb2
PYTHON_PYASN1_SETUP_TYPE = setuptools
PYTHON_PYASN1_LICENSE = BSD-2-Clause
PYTHON_PYASN1_LICENSE_FILES = LICENSE.rst

$(eval $(python-package))
