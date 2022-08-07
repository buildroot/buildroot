################################################################################
#
# python-rtoml
#
################################################################################

PYTHON_RTOML_VERSION = 0.8.0
PYTHON_RTOML_SOURCE = rtoml-$(PYTHON_RTOML_VERSION).tar.gz
PYTHON_RTOML_SITE = https://files.pythonhosted.org/packages/33/a6/b42d8e0e28bec9fd7fdbafb2d76db3f8578f151a669eba564d422756d909
PYTHON_RTOML_SETUP_TYPE = setuptools-rust
PYTHON_RTOML_LICENSE = MIT
PYTHON_RTOML_LICENSE_FILES = LICENSE

$(eval $(python-package))
