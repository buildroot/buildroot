################################################################################
#
# python-ruamel-yaml-clib
#
################################################################################

PYTHON_RUAMEL_YAML_CLIB_VERSION = 0.2.15
PYTHON_RUAMEL_YAML_CLIB_SOURCE = ruamel_yaml_clib-$(PYTHON_RUAMEL_YAML_CLIB_VERSION).tar.gz
PYTHON_RUAMEL_YAML_CLIB_SITE = https://files.pythonhosted.org/packages/ea/97/60fda20e2fb54b83a61ae14648b0817c8f5d84a3821e40bfbdae1437026a
PYTHON_RUAMEL_YAML_CLIB_SETUP_TYPE = setuptools
PYTHON_RUAMEL_YAML_CLIB_LICENSE = MIT
PYTHON_RUAMEL_YAML_CLIB_LICENSE_FILES = LICENSE

$(eval $(python-package))
