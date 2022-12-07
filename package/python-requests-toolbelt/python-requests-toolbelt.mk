################################################################################
#
# python-requests-toolbelt
#
################################################################################

PYTHON_REQUESTS_TOOLBELT_VERSION = 0.10.1
PYTHON_REQUESTS_TOOLBELT_SOURCE = requests-toolbelt-$(PYTHON_REQUESTS_TOOLBELT_VERSION).tar.gz
PYTHON_REQUESTS_TOOLBELT_SITE = https://files.pythonhosted.org/packages/0c/4c/07f01c6ac44f7784fa399137fbc8d0cdc1b5d35304e8c0f278ad82105b58
PYTHON_REQUESTS_TOOLBELT_SETUP_TYPE = setuptools
PYTHON_REQUESTS_TOOLBELT_LICENSE = Apache-2.0
PYTHON_REQUESTS_TOOLBELT_LICENSE_FILES = LICENSE

$(eval $(python-package))
