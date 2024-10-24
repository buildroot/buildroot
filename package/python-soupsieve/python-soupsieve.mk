################################################################################
#
# python-soupsieve
#
################################################################################

PYTHON_SOUPSIEVE_VERSION = 2.6
PYTHON_SOUPSIEVE_SOURCE = soupsieve-$(PYTHON_SOUPSIEVE_VERSION).tar.gz
PYTHON_SOUPSIEVE_SITE = https://files.pythonhosted.org/packages/d7/ce/fbaeed4f9fb8b2daa961f90591662df6a86c1abf25c548329a86920aedfb
PYTHON_SOUPSIEVE_SETUP_TYPE = hatch
PYTHON_SOUPSIEVE_LICENSE = MIT
PYTHON_SOUPSIEVE_LICENSE_FILES = LICENSE.md

$(eval $(python-package))
