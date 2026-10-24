################################################################################
#
# python-multidict
#
################################################################################

PYTHON_MULTIDICT_VERSION = 7.2.0
PYTHON_MULTIDICT_SOURCE = multidict-$(PYTHON_MULTIDICT_VERSION).tar.gz
PYTHON_MULTIDICT_SITE = https://files.pythonhosted.org/packages/9b/18/0127fdb8aa54b1d29d5b8f752af088ad6aa47abe13adaa519377b0b331ab
PYTHON_MULTIDICT_SETUP_TYPE = setuptools
PYTHON_MULTIDICT_LICENSE = Apache-2.0
PYTHON_MULTIDICT_LICENSE_FILES = LICENSE

$(eval $(python-package))
