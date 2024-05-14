################################################################################
#
# python-rtoml
#
################################################################################

PYTHON_RTOML_VERSION = 0.10.0
PYTHON_RTOML_SOURCE_PYPI = rtoml-$(PYTHON_RTOML_VERSION).tar.gz
PYTHON_RTOML_SITE_PYPI = https://files.pythonhosted.org/packages/ca/b2/0e77a00e75ed582ec1c4c3a9e1eeed886a15c195bcce87b7daf1171c4115
PYTHON_RTOML_SITE = $(PYTHON_RTOML_SITE_PYPI)/$(PYTHON_RTOML_SOURCE_PYPI)?buildroot-path=filename
PYTHON_RTOML_SETUP_TYPE = maturin
PYTHON_RTOML_LICENSE = MIT
PYTHON_RTOML_LICENSE_FILES = LICENSE

$(eval $(python-package))
