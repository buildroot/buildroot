################################################################################
#
# python-engineio
#
################################################################################

PYTHON_ENGINEIO_VERSION = 4.15.1
PYTHON_ENGINEIO_SOURCE = python_engineio-$(PYTHON_ENGINEIO_VERSION).tar.gz
PYTHON_ENGINEIO_SITE = https://files.pythonhosted.org/packages/dd/91/b565807fa922620ed575b412bf978d032e4c5d79558b400fdbfe1008c95a
PYTHON_ENGINEIO_SETUP_TYPE = setuptools
PYTHON_ENGINEIO_LICENSE = MIT
PYTHON_ENGINEIO_LICENSE_FILES = LICENSE
PYTHON_ENGINEIO_CPE_ID_VALID = YES

$(eval $(python-package))
