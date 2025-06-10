################################################################################
#
# python-yamllint
#
################################################################################

PYTHON_YAMLLINT_VERSION = 1.37.1
PYTHON_YAMLLINT_SOURCE = yamllint-$(PYTHON_YAMLLINT_VERSION).tar.gz
PYTHON_YAMLLINT_SITE = https://files.pythonhosted.org/packages/46/f2/cd8b7584a48ee83f0bc94f8a32fea38734cefcdc6f7324c4d3bfc699457b
PYTHON_YAMLLINT_SETUP_TYPE = setuptools
PYTHON_YAMLLINT_LICENSE = GPL-3.0
PYTHON_YAMLLINT_LICENSE_FILES = LICENSE

HOST_PYTHON_YAMLLINT_DEPENDENCIES += \
	host-python-pathspec \
	host-python-pyyaml

$(eval $(python-package))
$(eval $(host-python-package))
