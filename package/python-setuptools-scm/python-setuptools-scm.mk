################################################################################
#
# python-setuptools-scm
#
################################################################################

PYTHON_SETUPTOOLS_SCM_VERSION = 7.1.0
PYTHON_SETUPTOOLS_SCM_SOURCE = setuptools_scm-$(PYTHON_SETUPTOOLS_SCM_VERSION).tar.gz
PYTHON_SETUPTOOLS_SCM_SITE = https://files.pythonhosted.org/packages/98/12/2c1e579bb968759fc512391473340d0661b1a8c96a59fb7c65b02eec1321
PYTHON_SETUPTOOLS_SCM_LICENSE = MIT
PYTHON_SETUPTOOLS_SCM_LICENSE_FILES = LICENSE
PYTHON_SETUPTOOLS_SCM_SETUP_TYPE = setuptools

HOST_PYTHON_SETUPTOOLS_SCM_DEPENDENCIES = \
	host-python-packaging \
	host-python-typing-extensions

$(eval $(host-python-package))
