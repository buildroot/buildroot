################################################################################
#
# python-setuptools-scm
#
################################################################################

PYTHON_SETUPTOOLS_SCM_VERSION = 8.3.1
PYTHON_SETUPTOOLS_SCM_SOURCE = setuptools_scm-$(PYTHON_SETUPTOOLS_SCM_VERSION).tar.gz
PYTHON_SETUPTOOLS_SCM_SITE = https://files.pythonhosted.org/packages/b9/19/7ae64b70b2429c48c3a7a4ed36f50f94687d3bfcd0ae2f152367b6410dff
PYTHON_SETUPTOOLS_SCM_LICENSE = MIT
PYTHON_SETUPTOOLS_SCM_LICENSE_FILES = LICENSE
PYTHON_SETUPTOOLS_SCM_SETUP_TYPE = pep517

HOST_PYTHON_SETUPTOOLS_SCM_DEPENDENCIES = \
	host-python-packaging \
	host-python-setuptools

$(eval $(host-python-package))
