################################################################################
#
# python-pyproject-metadata
#
################################################################################

PYTHON_PYPROJECT_METADATA_VERSION = 0.9.0
PYTHON_PYPROJECT_METADATA_SOURCE = pyproject_metadata-$(PYTHON_PYPROJECT_METADATA_VERSION).tar.gz
PYTHON_PYPROJECT_METADATA_SITE = https://files.pythonhosted.org/packages/c0/79/406a9f56c435caaaca4a1c66397e4f63ecd48a72a6c4fc1d9ecdaac66acb
PYTHON_PYPROJECT_METADATA_SETUP_TYPE = flit
PYTHON_PYPROJECT_METADATA_LICENSE = MIT
PYTHON_PYPROJECT_METADATA_LICENSE_FILES = LICENSE
HOST_PYTHON_PYPROJECT_METADATA_DEPENDENCIES = host-python-packaging

$(eval $(host-python-package))
