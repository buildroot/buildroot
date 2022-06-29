################################################################################
#
# python-setuptools-scm
#
################################################################################

PYTHON_SETUPTOOLS_SCM_VERSION = 7.0.3
PYTHON_SETUPTOOLS_SCM_SOURCE = setuptools_scm-$(PYTHON_SETUPTOOLS_SCM_VERSION).tar.gz
PYTHON_SETUPTOOLS_SCM_SITE = https://files.pythonhosted.org/packages/bc/e6/ac8b0c5076321b9b3e4318c32a8911a260d019be6584556a0b83a47dab4b
PYTHON_SETUPTOOLS_SCM_LICENSE = MIT
PYTHON_SETUPTOOLS_SCM_LICENSE_FILES = LICENSE
PYTHON_SETUPTOOLS_SCM_SETUP_TYPE = setuptools
HOST_PYTHON_SETUPTOOLS_SCM_DEPENDENCIES = host-python-packaging host-python-tomli

$(eval $(host-python-package))
