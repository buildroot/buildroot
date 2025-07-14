################################################################################
#
# python-pyproject-metadata
#
################################################################################

PYTHON_PYPROJECT_METADATA_VERSION = 0.9.1
PYTHON_PYPROJECT_METADATA_SOURCE = pyproject_metadata-$(PYTHON_PYPROJECT_METADATA_VERSION).tar.gz
PYTHON_PYPROJECT_METADATA_SITE = https://files.pythonhosted.org/packages/64/ae/5fa065b049e97f96880de0611dbba513f0ee313b6edd0a64664c7b46a8e8
PYTHON_PYPROJECT_METADATA_SETUP_TYPE = flit
PYTHON_PYPROJECT_METADATA_LICENSE = MIT
PYTHON_PYPROJECT_METADATA_LICENSE_FILES = LICENSE
HOST_PYTHON_PYPROJECT_METADATA_DEPENDENCIES = host-python-packaging

$(eval $(host-python-package))
