################################################################################
#
# python-aioconsole
#
################################################################################

PYTHON_AIOCONSOLE_VERSION = 0.6.2
PYTHON_AIOCONSOLE_SOURCE = aioconsole-$(PYTHON_AIOCONSOLE_VERSION).tar.gz
PYTHON_AIOCONSOLE_SITE = https://files.pythonhosted.org/packages/5f/14/e5c634fad6a95ffd602fbbd1aa107f05a8ffb79d33ec0d0477f3b137f8a9
PYTHON_AIOCONSOLE_SETUP_TYPE = setuptools
PYTHON_AIOCONSOLE_LICENSE = GPL-3.0
PYTHON_AIOCONSOLE_LICENSE_FILES = LICENSE

$(eval $(python-package))
