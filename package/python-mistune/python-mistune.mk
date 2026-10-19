################################################################################
#
# python-mistune
#
################################################################################

PYTHON_MISTUNE_VERSION = 3.4.0
PYTHON_MISTUNE_SOURCE = mistune-$(PYTHON_MISTUNE_VERSION).tar.gz
PYTHON_MISTUNE_SITE = https://files.pythonhosted.org/packages/96/eb/749a4e69bf7396e751ae37444abe997eff2254e695a8095b84d1c89c1181
PYTHON_MISTUNE_LICENSE = BSD-3-Clause
PYTHON_MISTUNE_LICENSE_FILES = LICENSE
PYTHON_MISTUNE_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
