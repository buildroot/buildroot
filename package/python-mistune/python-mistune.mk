################################################################################
#
# python-mistune
#
################################################################################

PYTHON_MISTUNE_VERSION = 3.1.4
PYTHON_MISTUNE_SOURCE = mistune-$(PYTHON_MISTUNE_VERSION).tar.gz
PYTHON_MISTUNE_SITE = https://files.pythonhosted.org/packages/d7/02/a7fb8b21d4d55ac93cdcde9d3638da5dd0ebdd3a4fed76c7725e10b81cbe
PYTHON_MISTUNE_LICENSE = BSD-3-Clause
PYTHON_MISTUNE_LICENSE_FILES = LICENSE
PYTHON_MISTUNE_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
