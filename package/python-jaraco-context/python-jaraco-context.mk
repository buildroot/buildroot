################################################################################
#
# python-jaraco-context
#
################################################################################

PYTHON_JARACO_CONTEXT_VERSION = 6.0.2
PYTHON_JARACO_CONTEXT_SOURCE = jaraco_context-$(PYTHON_JARACO_CONTEXT_VERSION).tar.gz
PYTHON_JARACO_CONTEXT_SITE = https://files.pythonhosted.org/packages/8d/7d/41acf8e22d791bde812cb6c2c36128bb932ed8ae066bcb5e39cb198e8253
PYTHON_JARACO_CONTEXT_SETUP_TYPE = setuptools
PYTHON_JARACO_CONTEXT_LICENSE = MIT
PYTHON_JARACO_CONTEXT_LICENSE_FILES = LICENSE
PYTHON_JARACO_CONTEXT_DEPENDENCIES = \
	host-python-coherent-licensed \
	host-python-setuptools-scm

$(eval $(python-package))
