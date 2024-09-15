################################################################################
#
# python-jaraco-context
#
################################################################################

PYTHON_JARACO_CONTEXT_VERSION = 6.0.1
PYTHON_JARACO_CONTEXT_SOURCE = jaraco_context-$(PYTHON_JARACO_CONTEXT_VERSION).tar.gz
PYTHON_JARACO_CONTEXT_SITE = https://files.pythonhosted.org/packages/df/ad/f3777b81bf0b6e7bc7514a1656d3e637b2e8e15fab2ce3235730b3e7a4e6
PYTHON_JARACO_CONTEXT_SETUP_TYPE = setuptools
PYTHON_JARACO_CONTEXT_LICENSE = MIT
PYTHON_JARACO_CONTEXT_LICENSE_FILES = LICENSE
PYTHON_JARACO_CONTEXT_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
