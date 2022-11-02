################################################################################
#
# python-jaraco-functools
#
################################################################################

PYTHON_JARACO_FUNCTOOLS_VERSION = 3.5.2
PYTHON_JARACO_FUNCTOOLS_SOURCE = jaraco.functools-$(PYTHON_JARACO_FUNCTOOLS_VERSION).tar.gz
PYTHON_JARACO_FUNCTOOLS_SITE = https://files.pythonhosted.org/packages/b4/ea/9abca360081de9157668fcc52765989158aaf29b4826f26fcb17852d08e6
PYTHON_JARACO_FUNCTOOLS_LICENSE = MIT
PYTHON_JARACO_FUNCTOOLS_LICENSE_FILES = LICENSE
PYTHON_JARACO_FUNCTOOLS_SETUP_TYPE = setuptools
PYTHON_JARACO_FUNCTOOLS_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
