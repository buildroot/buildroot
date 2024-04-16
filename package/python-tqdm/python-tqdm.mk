################################################################################
#
# python-tqdm
#
################################################################################

PYTHON_TQDM_VERSION = 4.64.1
PYTHON_TQDM_SOURCE = tqdm-$(PYTHON_TQDM_VERSION).tar.gz
PYTHON_TQDM_SITE = https://files.pythonhosted.org/packages/c1/c2/d8a40e5363fb01806870e444fc1d066282743292ff32a9da54af51ce36a2
PYTHON_TQDM_SETUP_TYPE = setuptools
PYTHON_TQDM_LICENSE = MPL-2.0, MIT
PYTHON_TQDM_LICENSE_FILES = LICENCE
PYTHON_TQDM_CPE_ID_VENDOR = tqdm_project
PYTHON_TQDM_CPE_ID_PRODUCT = tqdm
PYTHON_TQDM_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
