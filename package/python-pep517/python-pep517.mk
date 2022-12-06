################################################################################
#
# python-pep517
#
################################################################################

PYTHON_PEP517_VERSION = 0.13.0
PYTHON_PEP517_SOURCE = pep517-$(PYTHON_PEP517_VERSION).tar.gz
PYTHON_PEP517_SITE = https://files.pythonhosted.org/packages/4d/19/e11fcc88288f68ae48e3aa9cf5a6fd092a88e629cb723465666c44d487a0
PYTHON_PEP517_LICENSE = MIT
PYTHON_PEP517_LICENSE_FILES = LICENSE
PYTHON_PEP517_SETUP_TYPE = flit-bootstrap

$(eval $(host-python-package))
