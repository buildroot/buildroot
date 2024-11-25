################################################################################
#
# python-smmap2
#
################################################################################

PYTHON_SMMAP2_VERSION = 5.0.1
PYTHON_SMMAP2_SOURCE = smmap-$(PYTHON_SMMAP2_VERSION).tar.gz
PYTHON_SMMAP2_SITE = https://files.pythonhosted.org/packages/88/04/b5bf6d21dc4041000ccba7eb17dd3055feb237e7ffc2c20d3fae3af62baa
PYTHON_SMMAP2_SETUP_TYPE = setuptools
PYTHON_SMMAP2_LICENSE = BSD-3-Clause
PYTHON_SMMAP2_LICENSE_FILES = LICENSE

$(eval $(python-package))
