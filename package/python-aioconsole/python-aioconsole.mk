################################################################################
#
# python-aioconsole
#
################################################################################

PYTHON_AIOCONSOLE_VERSION = 0.3.3
PYTHON_AIOCONSOLE_SOURCE = aioconsole-$(PYTHON_AIOCONSOLE_VERSION).tar.gz
PYTHON_AIOCONSOLE_SITE = https://files.pythonhosted.org/packages/dd/f6/bbc451ba96c1e1da6aa253f254b181ceb03272b475b27b481b57865d7d7f
PYTHON_AIOCONSOLE_SETUP_TYPE = setuptools
PYTHON_AIOCONSOLE_LICENSE = GPL-3.0
PYTHON_AIOCONSOLE_LICENSE_FILES = LICENSE

$(eval $(python-package))
