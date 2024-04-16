################################################################################
#
# python-pydal
#
################################################################################

PYTHON_PYDAL_VERSION = 20231114.3
PYTHON_PYDAL_SOURCE = pydal-$(PYTHON_PYDAL_VERSION).tar.gz
PYTHON_PYDAL_SITE = https://files.pythonhosted.org/packages/0b/3b/86302e165af07bc3d9225aea6ed8f52386270220e4aac1aad0101a48aac1
PYTHON_PYDAL_LICENSE = BSD-3-Clause
PYTHON_PYDAL_LICENSE_FILES = LICENSE.txt
PYTHON_PYDAL_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
