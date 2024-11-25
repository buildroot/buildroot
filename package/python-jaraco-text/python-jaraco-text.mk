################################################################################
#
# python-jaraco-text
#
################################################################################

PYTHON_JARACO_TEXT_VERSION = 4.0.0
PYTHON_JARACO_TEXT_SOURCE = jaraco_text-$(PYTHON_JARACO_TEXT_VERSION).tar.gz
PYTHON_JARACO_TEXT_SITE = https://files.pythonhosted.org/packages/4f/00/1b4dbbc5c6dcb87a4278cc229b2b560484bf231bba7922686c5139e5f934
PYTHON_JARACO_TEXT_SETUP_TYPE = setuptools
PYTHON_JARACO_TEXT_LICENSE = MIT
PYTHON_JARACO_TEXT_LICENSE_FILES = LICENSE
PYTHON_JARACO_TEXT_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
