################################################################################
#
# python-jaraco-functools
#
################################################################################

PYTHON_JARACO_FUNCTOOLS_VERSION = 4.0.2
PYTHON_JARACO_FUNCTOOLS_SOURCE = jaraco_functools-$(PYTHON_JARACO_FUNCTOOLS_VERSION).tar.gz
PYTHON_JARACO_FUNCTOOLS_SITE = https://files.pythonhosted.org/packages/03/b1/6ca3c2052e584e9908a2c146f00378939b3c51b839304ab8ef4de067f042
PYTHON_JARACO_FUNCTOOLS_LICENSE = MIT
PYTHON_JARACO_FUNCTOOLS_LICENSE_FILES = LICENSE
PYTHON_JARACO_FUNCTOOLS_SETUP_TYPE = setuptools
PYTHON_JARACO_FUNCTOOLS_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
