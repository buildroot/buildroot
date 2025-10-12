################################################################################
#
# python-mypy
#
################################################################################

PYTHON_MYPY_VERSION = 1.18.2
PYTHON_MYPY_SOURCE = mypy-$(PYTHON_MYPY_VERSION).tar.gz
PYTHON_MYPY_SITE = https://files.pythonhosted.org/packages/c0/77/8f0d0001ffad290cef2f7f216f96c814866248a0b92a722365ed54648e7e
PYTHON_MYPY_SETUP_TYPE = setuptools
PYTHON_MYPY_LICENSE = Apache-2.0, Python-2.0.1
PYTHON_MYPY_LICENSE_FILES = LICENSE
PYTHON_MYPY_DEPENDENCIES = \
	host-python-mypy-extensions \
	host-python-pathspec \
	host-python-types-psutil \
	host-python-types-setuptools \
	host-python-typing-extensions
HOST_PYTHON_MYPY_DEPENDENCIES = \
	host-python-mypy-extensions \
	host-python-pathspec \
	host-python-types-psutil \
	host-python-types-setuptools \
	host-python-typing-extensions

$(eval $(python-package))
$(eval $(host-python-package))
