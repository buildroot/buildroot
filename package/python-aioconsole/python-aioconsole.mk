################################################################################
#
# python-aioconsole
#
################################################################################

PYTHON_AIOCONSOLE_VERSION = 0.2.1
PYTHON_AIOCONSOLE_SOURCE = aioconsole-$(PYTHON_AIOCONSOLE_VERSION).tar.gz
PYTHON_AIOCONSOLE_SITE = https://files.pythonhosted.org/packages/06/24/d88c186e84457b6a7a2a01c21ccf1e9a1125b5d33157acb28388bfc0a73c
PYTHON_AIOCONSOLE_SETUP_TYPE = setuptools
PYTHON_AIOCONSOLE_LICENSE = GPL-3.0

$(eval $(python-package))
