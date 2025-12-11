################################################################################
#
# python-gast
#
################################################################################

PYTHON_GAST_VERSION = 0.7.0
PYTHON_GAST_SOURCE = gast-$(PYTHON_GAST_VERSION).tar.gz
PYTHON_GAST_SITE = https://files.pythonhosted.org/packages/91/f6/e73969782a2ecec280f8a176f2476149dd9dba69d5f8779ec6108a7721e6
PYTHON_GAST_SETUP_TYPE = setuptools
PYTHON_GAST_LICENSE = BSD-3-Clause
PYTHON_GAST_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
