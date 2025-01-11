################################################################################
#
# python-mistune
#
################################################################################

PYTHON_MISTUNE_VERSION = 3.1.0
PYTHON_MISTUNE_SOURCE = mistune-$(PYTHON_MISTUNE_VERSION).tar.gz
PYTHON_MISTUNE_SITE = https://files.pythonhosted.org/packages/79/6e/96fc7cb3288666c5de2c396eb0e338dc95f7a8e4920e43e38783a22d0084
PYTHON_MISTUNE_LICENSE = BSD-3-Clause
PYTHON_MISTUNE_LICENSE_FILES = LICENSE
PYTHON_MISTUNE_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
