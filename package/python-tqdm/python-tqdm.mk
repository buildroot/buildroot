################################################################################
#
# python-tqdm
#
################################################################################

PYTHON_TQDM_VERSION = 4.66.6
PYTHON_TQDM_SOURCE = tqdm-$(PYTHON_TQDM_VERSION).tar.gz
PYTHON_TQDM_SITE =  https://files.pythonhosted.org/packages/e9/34/bef135b27fe1864993a5284ad001157ee9b5538e859ac90f5b0e8cc8c9ec
PYTHON_TQDM_SETUP_TYPE = setuptools
PYTHON_TQDM_LICENSE = MPL-2.0, MIT
PYTHON_TQDM_LICENSE_FILES = LICENCE
PYTHON_TQDM_CPE_ID_VENDOR = tqdm_project
PYTHON_TQDM_CPE_ID_PRODUCT = tqdm
PYTHON_TQDM_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
