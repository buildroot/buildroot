################################################################################
#
# python-pep517
#
################################################################################

PYTHON_PEP517_VERSION = 0.12.0
PYTHON_PEP517_SOURCE = pep517-$(PYTHON_PEP517_VERSION).tar.gz
PYTHON_PEP517_SITE = https://files.pythonhosted.org/packages/0a/65/6e656d49c679136edfba25f25791f45ffe1ea4ae2ec1c59fe9c35e061cd1
PYTHON_PEP517_LICENSE = MIT
PYTHON_PEP517_LICENSE_FILES = LICENSE
PYTHON_PEP517_SETUP_TYPE = flit-bootstrap
HOST_PYTHON_PEP517_DEPENDENCIES = host-python-tomli

$(eval $(host-python-package))
