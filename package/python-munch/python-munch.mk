################################################################################
#
# python-munch
#
################################################################################

PYTHON_MUNCH_VERSION = 2.5.0
PYTHON_MUNCH_SOURCE = munch-$(PYTHON_MUNCH_VERSION).tar.gz
PYTHON_MUNCH_SITE = https://files.pythonhosted.org/packages/43/a1/ec48010724eedfe2add68eb7592a0d238590e14e08b95a4ffb3c7b2f0808
PYTHON_MUNCH_SETUP_TYPE = setuptools
PYTHON_MUNCH_LICENSE = MIT
PYTHON_MUNCH_LICENSE_FILES = LICENSE.txt
PYTHON_MUNCH_DEPENDENCIES = host-python-pbr

$(eval $(python-package))
