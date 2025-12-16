################################################################################
#
# python-soupsieve
#
################################################################################

PYTHON_SOUPSIEVE_VERSION = 2.8
PYTHON_SOUPSIEVE_SOURCE = soupsieve-$(PYTHON_SOUPSIEVE_VERSION).tar.gz
PYTHON_SOUPSIEVE_SITE = https://files.pythonhosted.org/packages/6d/e6/21ccce3262dd4889aa3332e5a119a3491a95e8f60939870a3a035aabac0d
PYTHON_SOUPSIEVE_SETUP_TYPE = hatch
PYTHON_SOUPSIEVE_LICENSE = MIT
PYTHON_SOUPSIEVE_LICENSE_FILES = LICENSE.md

$(eval $(python-package))
