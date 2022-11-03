################################################################################
#
# python-pyelftools
#
################################################################################

PYTHON_PYELFTOOLS_VERSION = 0.29
PYTHON_PYELFTOOLS_SOURCE = pyelftools-$(PYTHON_PYELFTOOLS_VERSION).tar.gz
PYTHON_PYELFTOOLS_SITE = https://files.pythonhosted.org/packages/0e/35/e76da824595452a5ad07f289ea1737ca0971fc6cc7b6ee9464279be06b5e
PYTHON_PYELFTOOLS_LICENSE = Public domain
PYTHON_PYELFTOOLS_LICENSE_FILES = LICENSE
PYTHON_PYELFTOOLS_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
