################################################################################
#
# python-aioconsole
#
################################################################################

PYTHON_AIOCONSOLE_VERSION = 0.8.0
PYTHON_AIOCONSOLE_SOURCE = aioconsole-$(PYTHON_AIOCONSOLE_VERSION).tar.gz
PYTHON_AIOCONSOLE_SITE = https://files.pythonhosted.org/packages/89/dc/523222a45a83e69319724362db1664185970bca20c7d643c9261cfcddfb1
PYTHON_AIOCONSOLE_SETUP_TYPE = setuptools
PYTHON_AIOCONSOLE_LICENSE = GPL-3.0
PYTHON_AIOCONSOLE_LICENSE_FILES = LICENSE

$(eval $(python-package))
