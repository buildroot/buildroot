################################################################################
#
# python-toml
#
################################################################################

PYTHON_TOML_VERSION = 0.10.2
PYTHON_TOML_SOURCE = toml-$(PYTHON_TOML_VERSION).tar.gz
PYTHON_TOML_SITE = https://files.pythonhosted.org/packages/be/ba/1f744cdc819428fc6b5084ec34d9b30660f6f9daaf70eead706e3203ec3c
PYTHON_TOML_SETUP_TYPE = setuptools
PYTHON_TOML_LICENSE = MIT
PYTHON_TOML_LICENSE_FILES = LICENSE

$(eval $(python-package))
$(eval $(host-python-package))
