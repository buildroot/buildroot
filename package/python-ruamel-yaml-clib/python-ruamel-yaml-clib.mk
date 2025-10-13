################################################################################
#
# python-ruamel-yaml-clib
#
################################################################################

PYTHON_RUAMEL_YAML_CLIB_VERSION = 0.2.14
PYTHON_RUAMEL_YAML_CLIB_SOURCE = ruamel.yaml.clib-$(PYTHON_RUAMEL_YAML_CLIB_VERSION).tar.gz
PYTHON_RUAMEL_YAML_CLIB_SITE = https://files.pythonhosted.org/packages/d8/e9/39ec4d4b3f91188fad1842748f67d4e749c77c37e353c4e545052ee8e893
PYTHON_RUAMEL_YAML_CLIB_SETUP_TYPE = setuptools
PYTHON_RUAMEL_YAML_CLIB_LICENSE = MIT
PYTHON_RUAMEL_YAML_CLIB_LICENSE_FILES = LICENSE

$(eval $(python-package))
