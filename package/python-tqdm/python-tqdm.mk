################################################################################
#
# python-tqdm
#
################################################################################

PYTHON_TQDM_VERSION = 4.66.5
PYTHON_TQDM_SOURCE = tqdm-$(PYTHON_TQDM_VERSION).tar.gz
PYTHON_TQDM_SITE = https://files.pythonhosted.org/packages/58/83/6ba9844a41128c62e810fddddd72473201f3eacde02046066142a2d96cc5
PYTHON_TQDM_SETUP_TYPE = setuptools
PYTHON_TQDM_LICENSE = MPL-2.0, MIT
PYTHON_TQDM_LICENSE_FILES = LICENCE
PYTHON_TQDM_CPE_ID_VENDOR = tqdm_project
PYTHON_TQDM_CPE_ID_PRODUCT = tqdm
PYTHON_TQDM_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
