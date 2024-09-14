################################################################################
#
# python-beniget
#
################################################################################

PYTHON_BENIGET_VERSION = 0.4.2.post1
PYTHON_BENIGET_SOURCE = beniget-$(PYTHON_BENIGET_VERSION).tar.gz
PYTHON_BENIGET_SITE = https://files.pythonhosted.org/packages/2e/27/5bb01af8f2860d431b98d0721b96ff2cea979106cae3f2d093ec74f6400c
PYTHON_BENIGET_SETUP_TYPE = setuptools
PYTHON_BENIGET_LICENSE = BSD-3-Clause
PYTHON_BENIGET_LICENSE_FILES = LICENSE
HOST_PYTHON_BENIGET_DEPENDENCIES = host-python-gast

$(eval $(host-python-package))
