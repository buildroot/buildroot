################################################################################
#
# python-pyproject-metadata
#
################################################################################

PYTHON_PYPROJECT_METADATA_VERSION = 0.10.0
PYTHON_PYPROJECT_METADATA_SOURCE = pyproject_metadata-$(PYTHON_PYPROJECT_METADATA_VERSION).tar.gz
PYTHON_PYPROJECT_METADATA_SITE = https://files.pythonhosted.org/packages/75/bd/74706b3671c443944f487a42a0148a507b733c60600df1d34cde41e6d10b
PYTHON_PYPROJECT_METADATA_SETUP_TYPE = flit
PYTHON_PYPROJECT_METADATA_LICENSE = MIT
PYTHON_PYPROJECT_METADATA_LICENSE_FILES = LICENSE
HOST_PYTHON_PYPROJECT_METADATA_DEPENDENCIES = host-python-packaging

$(eval $(host-python-package))
