################################################################################
#
# python-mistune
#
################################################################################

PYTHON_MISTUNE_VERSION = 3.3.4
PYTHON_MISTUNE_SOURCE = mistune-$(PYTHON_MISTUNE_VERSION).tar.gz
PYTHON_MISTUNE_SITE = https://files.pythonhosted.org/packages/7b/92/328a294a6de83bacb95bed01f04e0eaff4e3616ee359fc821a5dfc539b02
PYTHON_MISTUNE_LICENSE = BSD-3-Clause
PYTHON_MISTUNE_LICENSE_FILES = LICENSE
PYTHON_MISTUNE_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
