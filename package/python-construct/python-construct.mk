################################################################################
#
# python-construct
#
################################################################################

PYTHON_CONSTRUCT_VERSION = 2.10.69
PYTHON_CONSTRUCT_SOURCE = construct-$(PYTHON_CONSTRUCT_VERSION).tar.gz
PYTHON_CONSTRUCT_SITE = https://files.pythonhosted.org/packages/02/88/e34d7265863f3c96077aea24041b067d4646d77d596d979110eb94758b03
PYTHON_CONSTRUCT_SETUP_TYPE = setuptools
PYTHON_CONSTRUCT_LICENSE = MIT
PYTHON_CONSTRUCT_LICENSE_FILES = LICENSE

$(eval $(python-package))
