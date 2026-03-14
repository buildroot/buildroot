################################################################################
#
# python-pyproject-metadata
#
################################################################################

PYTHON_PYPROJECT_METADATA_VERSION = 0.11.0
PYTHON_PYPROJECT_METADATA_SOURCE = pyproject_metadata-$(PYTHON_PYPROJECT_METADATA_VERSION).tar.gz
PYTHON_PYPROJECT_METADATA_SITE = https://files.pythonhosted.org/packages/83/fa/8bf4fa41adfebd95dce360afe3f5fca243a17932089d3d5486e95ca44c57
PYTHON_PYPROJECT_METADATA_SETUP_TYPE = flit
PYTHON_PYPROJECT_METADATA_LICENSE = MIT
PYTHON_PYPROJECT_METADATA_LICENSE_FILES = LICENSE
HOST_PYTHON_PYPROJECT_METADATA_DEPENDENCIES = host-python-packaging

$(eval $(host-python-package))
