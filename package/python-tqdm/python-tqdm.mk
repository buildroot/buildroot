################################################################################
#
# python-tqdm
#
################################################################################

PYTHON_TQDM_VERSION = 4.67.0
PYTHON_TQDM_SOURCE = tqdm-$(PYTHON_TQDM_VERSION).tar.gz
PYTHON_TQDM_SITE = https://files.pythonhosted.org/packages/e8/4f/0153c21dc5779a49a0598c445b1978126b1344bab9ee71e53e44877e14e0
PYTHON_TQDM_SETUP_TYPE = setuptools
PYTHON_TQDM_LICENSE = MPL-2.0, MIT
PYTHON_TQDM_LICENSE_FILES = LICENCE
PYTHON_TQDM_CPE_ID_VENDOR = tqdm_project
PYTHON_TQDM_CPE_ID_PRODUCT = tqdm
PYTHON_TQDM_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
