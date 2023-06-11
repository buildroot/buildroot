################################################################################
#
# python-pyjwt
#
################################################################################

PYTHON_PYJWT_VERSION = 2.7.0
PYTHON_PYJWT_SOURCE = PyJWT-$(PYTHON_PYJWT_VERSION).tar.gz
PYTHON_PYJWT_SITE = https://files.pythonhosted.org/packages/e0/f0/9804c72e9a314360c135f42c434eb42eaabb5e7ebad760cbd8fc7023be38
PYTHON_PYJWT_SETUP_TYPE = setuptools
PYTHON_PYJWT_LICENSE = MIT
PYTHON_PYJWT_LICENSE_FILES = LICENSE
PYTHON_PYJWT_CPE_ID_VENDOR = pyjwt_project
PYTHON_PYJWT_CPE_ID_PRODUCT = pyjwt

$(eval $(python-package))
