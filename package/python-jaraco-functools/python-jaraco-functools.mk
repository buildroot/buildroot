################################################################################
#
# python-jaraco-functools
#
################################################################################

PYTHON_JARACO_FUNCTOOLS_VERSION = 4.0.0
PYTHON_JARACO_FUNCTOOLS_SOURCE = jaraco.functools-$(PYTHON_JARACO_FUNCTOOLS_VERSION).tar.gz
PYTHON_JARACO_FUNCTOOLS_SITE = https://files.pythonhosted.org/packages/57/7c/fe770e264913f9a49ddb9387cca2757b8d7d26f06735c1bfbb018912afce
PYTHON_JARACO_FUNCTOOLS_LICENSE = MIT
PYTHON_JARACO_FUNCTOOLS_LICENSE_FILES = LICENSE
PYTHON_JARACO_FUNCTOOLS_SETUP_TYPE = setuptools
PYTHON_JARACO_FUNCTOOLS_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
