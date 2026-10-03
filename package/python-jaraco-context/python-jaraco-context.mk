################################################################################
#
# python-jaraco-context
#
################################################################################

PYTHON_JARACO_CONTEXT_VERSION = 6.1.2
PYTHON_JARACO_CONTEXT_SOURCE = jaraco_context-$(PYTHON_JARACO_CONTEXT_VERSION).tar.gz
PYTHON_JARACO_CONTEXT_SITE = https://files.pythonhosted.org/packages/af/50/4763cd07e722bb6285316d390a164bc7e479db9d90daa769f22578f698b4
PYTHON_JARACO_CONTEXT_SETUP_TYPE = setuptools
PYTHON_JARACO_CONTEXT_LICENSE = MIT
PYTHON_JARACO_CONTEXT_LICENSE_FILES = LICENSE
PYTHON_JARACO_CONTEXT_DEPENDENCIES = \
	host-python-coherent-licensed \
	host-python-setuptools-scm

$(eval $(python-package))
