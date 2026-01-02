################################################################################
#
# python-jaraco-functools
#
################################################################################

PYTHON_JARACO_FUNCTOOLS_VERSION = 4.4.0
PYTHON_JARACO_FUNCTOOLS_SOURCE = jaraco_functools-$(PYTHON_JARACO_FUNCTOOLS_VERSION).tar.gz
PYTHON_JARACO_FUNCTOOLS_SITE = https://files.pythonhosted.org/packages/0f/27/056e0638a86749374d6f57d0b0db39f29509cce9313cf91bdc0ac4d91084
PYTHON_JARACO_FUNCTOOLS_LICENSE = MIT
PYTHON_JARACO_FUNCTOOLS_LICENSE_FILES = LICENSE
PYTHON_JARACO_FUNCTOOLS_SETUP_TYPE = setuptools
PYTHON_JARACO_FUNCTOOLS_DEPENDENCIES = \
	host-python-coherent-licensed \
	host-python-setuptools-scm

$(eval $(python-package))
