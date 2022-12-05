################################################################################
#
# python-mistune
#
################################################################################

PYTHON_MISTUNE_VERSION = 2.0.4
PYTHON_MISTUNE_SOURCE = mistune-$(PYTHON_MISTUNE_VERSION).tar.gz
PYTHON_MISTUNE_SITE = https://files.pythonhosted.org/packages/cd/9b/0f98334812f548a5ee4399b76e33752a74fc7bb976f5efb34d962f03d585
PYTHON_MISTUNE_LICENSE = BSD-3-Clause
PYTHON_MISTUNE_LICENSE_FILES = LICENSE
PYTHON_MISTUNE_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
