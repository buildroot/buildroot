################################################################################
#
# python-mypy
#
################################################################################

PYTHON_MYPY_VERSION = 1.14.1
PYTHON_MYPY_SOURCE = mypy-$(PYTHON_MYPY_VERSION).tar.gz
PYTHON_MYPY_SITE = https://files.pythonhosted.org/packages/b9/eb/2c92d8ea1e684440f54fa49ac5d9a5f19967b7b472a281f419e69a8d228e
PYTHON_MYPY_SETUP_TYPE = setuptools
PYTHON_MYPY_LICENSE = Apache-2.0, Python-2.0.1
PYTHON_MYPY_LICENSE_FILES = LICENSE
PYTHON_MYPY_DEPENDENCIES = \
	host-python-mypy-extensions \
	host-python-types-psutil \
	host-python-types-setuptools \
	host-python-typing-extensions
HOST_PYTHON_MYPY_DEPENDENCIES = \
	host-python-mypy-extensions \
	host-python-types-psutil \
	host-python-types-setuptools \
	host-python-typing-extensions

$(eval $(python-package))
$(eval $(host-python-package))
