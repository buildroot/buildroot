################################################################################
#
# python-pycups
#
################################################################################

PYTHON_PYCUPS_VERSION = 2.0.4
PYTHON_PYCUPS_SOURCE = pycups-$(PYTHON_PYCUPS_VERSION).tar.gz
PYTHON_PYCUPS_SITE = https://files.pythonhosted.org/packages/96/c4/b077f0422cd031e4f3a47c75ce0bcf77f2f2e5bf3648f6945a4d09fd44a5
PYTHON_PYCUPS_SETUP_TYPE = setuptools
PYTHON_PYCUPS_LICENSE = GPL-2.0+
PYTHON_PYCUPS_LICENSE_FILES = COPYING
PYTHON_PYCUPS_DEPENDENCIES = cups

$(eval $(python-package))
