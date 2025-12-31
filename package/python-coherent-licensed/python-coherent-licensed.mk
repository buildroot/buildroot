################################################################################
#
# python-coherent-licensed
#
################################################################################

PYTHON_COHERENT_LICENSED_VERSION = 0.5.2
PYTHON_COHERENT_LICENSED_SOURCE = coherent_licensed-$(PYTHON_COHERENT_LICENSED_VERSION).tar.gz
PYTHON_COHERENT_LICENSED_SITE = https://files.pythonhosted.org/packages/cd/e9/63d2dcccb5496cc99d96f29a8a5f3e2c6ed0bba7fedb840862f92816ee17
PYTHON_COHERENT_LICENSED_SETUP_TYPE = flit
PYTHON_COHERENT_LICENSED_LICENSE = MIT
PYTHON_COHERENT_LICENSED_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
