################################################################################
#
# python-jaraco-context
#
################################################################################

PYTHON_JARACO_CONTEXT_VERSION = 4.3.0
PYTHON_JARACO_CONTEXT_SOURCE = jaraco.context-$(PYTHON_JARACO_CONTEXT_VERSION).tar.gz
PYTHON_JARACO_CONTEXT_SITE = https://files.pythonhosted.org/packages/7c/b4/fa71f82b83ebeed95fe45ce587d6cba85b7c09ef3d9f61602f92f45e90db
PYTHON_JARACO_CONTEXT_SETUP_TYPE = setuptools
PYTHON_JARACO_CONTEXT_LICENSE = MIT
PYTHON_JARACO_CONTEXT_LICENSE_FILES = LICENSE
PYTHON_JARACO_CONTEXT_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
