################################################################################
#
# python-ruamel-yaml-clib
#
################################################################################

PYTHON_RUAMEL_YAML_CLIB_VERSION = 0.2.12
PYTHON_RUAMEL_YAML_CLIB_SOURCE = ruamel.yaml.clib-$(PYTHON_RUAMEL_YAML_CLIB_VERSION).tar.gz
PYTHON_RUAMEL_YAML_CLIB_SITE = https://files.pythonhosted.org/packages/20/84/80203abff8ea4993a87d823a5f632e4d92831ef75d404c9fc78d0176d2b5
PYTHON_RUAMEL_YAML_CLIB_SETUP_TYPE = setuptools
PYTHON_RUAMEL_YAML_CLIB_LICENSE = MIT
PYTHON_RUAMEL_YAML_CLIB_LICENSE_FILES = LICENSE

$(eval $(python-package))
