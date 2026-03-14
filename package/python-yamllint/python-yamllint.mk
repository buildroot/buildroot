################################################################################
#
# python-yamllint
#
################################################################################

PYTHON_YAMLLINT_VERSION = 1.38.0
PYTHON_YAMLLINT_SOURCE = yamllint-$(PYTHON_YAMLLINT_VERSION).tar.gz
PYTHON_YAMLLINT_SITE = https://files.pythonhosted.org/packages/28/a0/8fc2d68e132cf918f18273fdc8a1b8432b60d75ac12fdae4b0ef5c9d2e8d
PYTHON_YAMLLINT_SETUP_TYPE = setuptools
PYTHON_YAMLLINT_LICENSE = GPL-3.0
PYTHON_YAMLLINT_LICENSE_FILES = LICENSE

HOST_PYTHON_YAMLLINT_DEPENDENCIES += \
	host-python-pathspec \
	host-python-pyyaml

$(eval $(python-package))
$(eval $(host-python-package))
