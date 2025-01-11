################################################################################
#
# python-pydal
#
################################################################################

PYTHON_PYDAL_VERSION = 20241204.1
PYTHON_PYDAL_SOURCE = pydal-$(PYTHON_PYDAL_VERSION).tar.gz
PYTHON_PYDAL_SITE = https://files.pythonhosted.org/packages/e8/78/7ddf9aacea5cd2e63423d278d26465c63ecdae87cf1c503d8fc1f7dfcfa5
PYTHON_PYDAL_LICENSE = BSD-3-Clause
PYTHON_PYDAL_LICENSE_FILES = LICENSE.txt
PYTHON_PYDAL_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
