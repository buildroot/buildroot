################################################################################
#
# python-smmap2
#
################################################################################

PYTHON_SMMAP2_VERSION = 4.0.0
PYTHON_SMMAP2_SOURCE = smmap-$(PYTHON_SMMAP2_VERSION).tar.gz
PYTHON_SMMAP2_SITE = https://files.pythonhosted.org/packages/dd/d4/2b4f196171674109f0fbb3951b8beab06cd0453c1b247ec0c4556d06648d
PYTHON_SMMAP2_SETUP_TYPE = setuptools
PYTHON_SMMAP2_LICENSE = BSD-3-Clause
PYTHON_SMMAP2_LICENSE_FILES = LICENSE

$(eval $(python-package))
