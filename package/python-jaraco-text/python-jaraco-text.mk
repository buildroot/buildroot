################################################################################
#
# python-jaraco-text
#
################################################################################

PYTHON_JARACO_TEXT_VERSION = 4.3.0
PYTHON_JARACO_TEXT_SOURCE = jaraco_text-$(PYTHON_JARACO_TEXT_VERSION).tar.gz
PYTHON_JARACO_TEXT_SITE = https://files.pythonhosted.org/packages/be/8c/c74f1107719400477289d99cd2c0b5b7809a45f60acecfb5ef961c3533c8
PYTHON_JARACO_TEXT_SETUP_TYPE = setuptools
PYTHON_JARACO_TEXT_LICENSE = MIT
PYTHON_JARACO_TEXT_LICENSE_FILES = LICENSE
PYTHON_JARACO_TEXT_DEPENDENCIES = host-python-coherent-licensed host-python-setuptools-scm

$(eval $(python-package))
