################################################################################
#
# python-pyelftools
#
################################################################################

PYTHON_PYELFTOOLS_VERSION = 0.30
PYTHON_PYELFTOOLS_SOURCE = pyelftools-$(PYTHON_PYELFTOOLS_VERSION).tar.gz
PYTHON_PYELFTOOLS_SITE = https://files.pythonhosted.org/packages/84/05/fd41cd647de044d1ffec90ce5aaae935126ac217f8ecb302186655284fc8
PYTHON_PYELFTOOLS_LICENSE = Public domain
PYTHON_PYELFTOOLS_LICENSE_FILES = LICENSE
PYTHON_PYELFTOOLS_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
