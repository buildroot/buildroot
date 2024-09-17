################################################################################
#
# python-pyproject-metadata
#
################################################################################

PYTHON_PYPROJECT_METADATA_VERSION = 0.8.0
PYTHON_PYPROJECT_METADATA_SOURCE = pyproject_metadata-$(PYTHON_PYPROJECT_METADATA_VERSION).tar.gz
PYTHON_PYPROJECT_METADATA_SITE = https://files.pythonhosted.org/packages/cf/cc/428b057f8c229b7c374efe9d6a6a35e693f79e071e25846ab0c55e59d337
PYTHON_PYPROJECT_METADATA_SETUP_TYPE = setuptools
PYTHON_PYPROJECT_METADATA_LICENSE = MIT
PYTHON_PYPROJECT_METADATA_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
