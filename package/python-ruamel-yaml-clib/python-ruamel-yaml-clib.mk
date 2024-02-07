################################################################################
#
# python-ruamel-yaml-clib
#
################################################################################

PYTHON_RUAMEL_YAML_CLIB_VERSION = 0.2.8
PYTHON_RUAMEL_YAML_CLIB_SOURCE = ruamel.yaml.clib-$(PYTHON_RUAMEL_YAML_CLIB_VERSION).tar.gz
PYTHON_RUAMEL_YAML_CLIB_SITE = https://files.pythonhosted.org/packages/46/ab/bab9eb1566cd16f060b54055dd39cf6a34bfa0240c53a7218c43e974295b
PYTHON_RUAMEL_YAML_CLIB_SETUP_TYPE = setuptools
PYTHON_RUAMEL_YAML_CLIB_LICENSE = MIT
PYTHON_RUAMEL_YAML_CLIB_LICENSE_FILES = LICENSE

$(eval $(python-package))
