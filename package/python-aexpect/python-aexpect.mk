################################################################################
#
# python-aexpect
#
################################################################################

PYTHON_AEXPECT_VERSION = 1.6.4
PYTHON_AEXPECT_SOURCE = aexpect-$(PYTHON_AEXPECT_VERSION).tar.gz
PYTHON_AEXPECT_SITE = https://files.pythonhosted.org/packages/3b/22/f87ffa70348dde4597d9314995be89c8d4c7728260033b972a8d691e3f7d
PYTHON_AEXPECT_SETUP_TYPE = setuptools
PYTHON_AEXPECT_LICENSE = GPL-2.0+
PYTHON_AEXPECT_LICENSE_FILES = LICENSE

$(eval $(python-package))
