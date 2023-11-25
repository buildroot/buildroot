################################################################################
#
# python-pyproject-metadata
#
################################################################################

PYTHON_PYPROJECT_METADATA_VERSION = 0.7.1
PYTHON_PYPROJECT_METADATA_SOURCE = pyproject-metadata-$(PYTHON_PYPROJECT_METADATA_VERSION).tar.gz
PYTHON_PYPROJECT_METADATA_SITE = https://files.pythonhosted.org/packages/38/af/b0e6a9eba989870fd26e10889446d1bec2e6d5be0a1bae2dc4dcda9ce199
PYTHON_PYPROJECT_METADATA_SETUP_TYPE = setuptools
PYTHON_PYPROJECT_METADATA_LICENSE = MIT
PYTHON_PYPROJECT_METADATA_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
