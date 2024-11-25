################################################################################
#
# python-jaraco-functools
#
################################################################################

PYTHON_JARACO_FUNCTOOLS_VERSION = 4.1.0
PYTHON_JARACO_FUNCTOOLS_SOURCE = jaraco_functools-$(PYTHON_JARACO_FUNCTOOLS_VERSION).tar.gz
PYTHON_JARACO_FUNCTOOLS_SITE = https://files.pythonhosted.org/packages/ab/23/9894b3df5d0a6eb44611c36aec777823fc2e07740dabbd0b810e19594013
PYTHON_JARACO_FUNCTOOLS_LICENSE = MIT
PYTHON_JARACO_FUNCTOOLS_LICENSE_FILES = LICENSE
PYTHON_JARACO_FUNCTOOLS_SETUP_TYPE = setuptools
PYTHON_JARACO_FUNCTOOLS_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
