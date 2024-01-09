################################################################################
#
# python-jaraco-text
#
################################################################################

PYTHON_JARACO_TEXT_VERSION = 3.12.0
PYTHON_JARACO_TEXT_SOURCE = jaraco.text-$(PYTHON_JARACO_TEXT_VERSION).tar.gz
PYTHON_JARACO_TEXT_SITE = https://files.pythonhosted.org/packages/53/30/52edc6c9997d48b0d9fbedb6a29edab2b397968f637b76aae299a9128c34
PYTHON_JARACO_TEXT_SETUP_TYPE = setuptools
PYTHON_JARACO_TEXT_LICENSE = MIT
PYTHON_JARACO_TEXT_LICENSE_FILES = LICENSE
PYTHON_JARACO_TEXT_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
