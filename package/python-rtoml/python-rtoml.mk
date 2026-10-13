################################################################################
#
# python-rtoml
#
################################################################################

PYTHON_RTOML_VERSION = 0.14.0
PYTHON_RTOML_SOURCE_PYPI = rtoml-$(PYTHON_RTOML_VERSION).tar.gz
PYTHON_RTOML_SITE_PYPI = https://files.pythonhosted.org/packages/da/fb/ef915d0c607fb92674b16e15792ed9d254c9db0b3fbbea90b7be46fe3e2b
PYTHON_RTOML_SITE = $(PYTHON_RTOML_SITE_PYPI)/$(PYTHON_RTOML_SOURCE_PYPI)?buildroot-path=filename
PYTHON_RTOML_SETUP_TYPE = maturin
PYTHON_RTOML_LICENSE = MIT
PYTHON_RTOML_LICENSE_FILES = LICENSE

$(eval $(python-package))
