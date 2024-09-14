################################################################################
#
# python-bleak
#
################################################################################

PYTHON_BLEAK_VERSION = 0.22.2
PYTHON_BLEAK_SOURCE = bleak-$(PYTHON_BLEAK_VERSION).tar.gz
PYTHON_BLEAK_SITE = https://files.pythonhosted.org/packages/03/76/733131e2935f4fcdc7a0dd47cbc5090e12d578297804fb0482575db43f3c
PYTHON_BLEAK_SETUP_TYPE = pep517
PYTHON_BLEAK_LICENSE = MIT
PYTHON_BLEAK_LICENSE_FILES = LICENSE
PYTHON_BLEAK_DEPENDENCIES = host-python-poetry-core

$(eval $(python-package))
