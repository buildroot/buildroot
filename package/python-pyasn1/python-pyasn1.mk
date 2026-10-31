################################################################################
#
# python-pyasn1
#
################################################################################

PYTHON_PYASN1_VERSION = 0.6.5
PYTHON_PYASN1_SOURCE = pyasn1-$(PYTHON_PYASN1_VERSION).tar.gz
PYTHON_PYASN1_SITE = https://files.pythonhosted.org/packages/88/7e/3c0da41061a2021cac7cd524fd57092adbe5b515e8bf9005702e366802e2
PYTHON_PYASN1_SETUP_TYPE = setuptools
PYTHON_PYASN1_LICENSE = BSD-2-Clause
PYTHON_PYASN1_LICENSE_FILES = LICENSE.rst

$(eval $(python-package))
