################################################################################
#
# python-setuptools-scm
#
################################################################################

PYTHON_SETUPTOOLS_SCM_VERSION = 6.3.2
PYTHON_SETUPTOOLS_SCM_SOURCE = setuptools_scm-$(PYTHON_SETUPTOOLS_SCM_VERSION).tar.gz
PYTHON_SETUPTOOLS_SCM_SITE = https://files.pythonhosted.org/packages/4b/0d/ecb9595fae02467edba5023eb8a23c688d2b438a6a8d1a9e2b8649faf23d
PYTHON_SETUPTOOLS_SCM_LICENSE = MIT
PYTHON_SETUPTOOLS_SCM_LICENSE_FILES = LICENSE
PYTHON_SETUPTOOLS_SCM_SETUP_TYPE = setuptools
HOST_PYTHON_SETUPTOOLS_SCM_DEPENDENCIES = host-python-packaging host-python-tomli
HOST_PYTHON_SETUPTOOLS_SCM_NEEDS_HOST_PYTHON = python3

$(eval $(host-python-package))
