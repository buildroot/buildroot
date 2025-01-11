################################################################################
#
# python-tqdm
#
################################################################################

PYTHON_TQDM_VERSION = 4.67.1
PYTHON_TQDM_SOURCE = tqdm-$(PYTHON_TQDM_VERSION).tar.gz
PYTHON_TQDM_SITE = https://files.pythonhosted.org/packages/a8/4b/29b4ef32e036bb34e4ab51796dd745cdba7ed47ad142a9f4a1eb8e0c744d
PYTHON_TQDM_SETUP_TYPE = setuptools
PYTHON_TQDM_LICENSE = MPL-2.0, MIT
PYTHON_TQDM_LICENSE_FILES = LICENCE
PYTHON_TQDM_CPE_ID_VENDOR = tqdm_project
PYTHON_TQDM_CPE_ID_PRODUCT = tqdm
PYTHON_TQDM_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
