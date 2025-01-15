################################################################################
#
# python-smmap2
#
################################################################################

PYTHON_SMMAP2_VERSION = 5.0.2
PYTHON_SMMAP2_SOURCE = smmap-$(PYTHON_SMMAP2_VERSION).tar.gz
PYTHON_SMMAP2_SITE = https://files.pythonhosted.org/packages/44/cd/a040c4b3119bbe532e5b0732286f805445375489fceaec1f48306068ee3b
PYTHON_SMMAP2_SETUP_TYPE = setuptools
PYTHON_SMMAP2_LICENSE = BSD-3-Clause
PYTHON_SMMAP2_LICENSE_FILES = LICENSE

$(eval $(python-package))
