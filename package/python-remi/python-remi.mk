################################################################################
#
# python-remi
#
################################################################################

PYTHON_REMI_VERSION = 2021.3.2
PYTHON_REMI_SOURCE = remi-$(PYTHON_REMI_VERSION).tar.gz
PYTHON_REMI_SITE = https://files.pythonhosted.org/packages/c0/99/94bd825cf8baee369b959f76c802a51ccc69d4d62ec113e26db4835f710c
PYTHON_REMI_LICENSE = Apache-2.0
PYTHON_REMI_SETUP_TYPE = setuptools

$(eval $(python-package))
