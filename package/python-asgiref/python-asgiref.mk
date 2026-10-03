################################################################################
#
# python-asgiref
#
################################################################################

PYTHON_ASGIREF_VERSION = 3.12.1
PYTHON_ASGIREF_SOURCE = asgiref-$(PYTHON_ASGIREF_VERSION).tar.gz
PYTHON_ASGIREF_SITE = https://files.pythonhosted.org/packages/e6/26/3b59f2bdae5f640389becb1f673cded775287f5fc4f816309d9ca9a3f93d
PYTHON_ASGIREF_SETUP_TYPE = setuptools
PYTHON_ASGIREF_LICENSE = BSD-3-Clause
PYTHON_ASGIREF_LICENSE_FILES = LICENSE

$(eval $(python-package))
