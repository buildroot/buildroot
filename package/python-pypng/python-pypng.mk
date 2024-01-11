################################################################################
#
# python-pypng
#
################################################################################

PYTHON_PYPNG_VERSION = 0.20220715.0
PYTHON_PYPNG_SOURCE = pypng-$(PYTHON_PYPNG_VERSION).tar.gz
PYTHON_PYPNG_SITE = https://files.pythonhosted.org/packages/93/cd/112f092ec27cca83e0516de0a3368dbd9128c187fb6b52aaaa7cde39c96d
PYTHON_PYPNG_SETUP_TYPE = setuptools
PYTHON_PYPNG_LICENSE = MIT
PYTHON_PYPNG_LICENSE_FILES = LICENCE

$(eval $(python-package))
