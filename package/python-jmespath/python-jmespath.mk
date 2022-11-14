################################################################################
#
# python-jmespath
#
################################################################################

PYTHON_JMESPATH_VERSION = 1.0.0
PYTHON_JMESPATH_SOURCE = jmespath-$(PYTHON_JMESPATH_VERSION).tar.gz
PYTHON_JMESPATH_SITE = https://files.pythonhosted.org/packages/06/7e/44686b986ef9ca6069db224651baaa8300b93af2a085a5b135997bf659b3
PYTHON_JMESPATH_SETUP_TYPE = setuptools
PYTHON_JMESPATH_LICENSE = MIT
PYTHON_JMESPATH_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
