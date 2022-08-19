################################################################################
#
# python-connexion
#
################################################################################

PYTHON_CONNEXION_VERSION = 2.14.0
PYTHON_CONNEXION_SOURCE = connexion-$(PYTHON_CONNEXION_VERSION).tar.gz
PYTHON_CONNEXION_SITE = https://files.pythonhosted.org/packages/31/17/c8c525fc237876ec901d2ce75c47d777ad508a4ff91c3745c7bbfac3f506
PYTHON_CONNEXION_SETUP_TYPE = setuptools
PYTHON_CONNEXION_LICENSE = Apache License Version 2.0
PYTHON_CONNEXION_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
