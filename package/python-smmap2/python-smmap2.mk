################################################################################
#
# python-smmap2
#
################################################################################

PYTHON_SMMAP2_VERSION = 5.0.3
PYTHON_SMMAP2_SOURCE = smmap-$(PYTHON_SMMAP2_VERSION).tar.gz
PYTHON_SMMAP2_SITE = https://files.pythonhosted.org/packages/1f/ea/49c993d6dfdd7338c9b1000a0f36817ed7ec84577ae2e52f890d1a4ff909
PYTHON_SMMAP2_SETUP_TYPE = setuptools
PYTHON_SMMAP2_LICENSE = BSD-3-Clause
PYTHON_SMMAP2_LICENSE_FILES = LICENSE

$(eval $(python-package))
