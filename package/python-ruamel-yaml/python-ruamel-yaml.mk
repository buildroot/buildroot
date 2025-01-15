################################################################################
#
# python-ruamel-yaml
#
################################################################################

PYTHON_RUAMEL_YAML_VERSION = 0.18.10
PYTHON_RUAMEL_YAML_SOURCE = ruamel.yaml-$(PYTHON_RUAMEL_YAML_VERSION).tar.gz
PYTHON_RUAMEL_YAML_SITE = https://files.pythonhosted.org/packages/ea/46/f44d8be06b85bc7c4d8c95d658be2b68f27711f279bf9dd0612a5e4794f5
PYTHON_RUAMEL_YAML_SETUP_TYPE = setuptools
PYTHON_RUAMEL_YAML_LICENSE = MIT
PYTHON_RUAMEL_YAML_LICENSE_FILES = LICENSE
PYTHON_RUAMEL_YAML_CPE_ID_VENDOR = ruamel.yaml_project
PYTHON_RUAMEL_YAML_CPE_ID_PRODUCT = ruamel.yaml

$(eval $(python-package))
