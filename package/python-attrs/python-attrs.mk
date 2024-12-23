################################################################################
#
# python-attrs
#
################################################################################

PYTHON_ATTRS_VERSION = 24.3.0
PYTHON_ATTRS_SOURCE = attrs-$(PYTHON_ATTRS_VERSION).tar.gz
PYTHON_ATTRS_SITE = https://files.pythonhosted.org/packages/48/c8/6260f8ccc11f0917360fc0da435c5c9c7504e3db174d5a12a1494887b045
PYTHON_ATTRS_SETUP_TYPE = hatch
PYTHON_ATTRS_LICENSE = MIT
PYTHON_ATTRS_LICENSE_FILES = LICENSE
PYTHON_ATTRS_DEPENDENCIES = \
	host-python-hatch-fancy-pypi-readme \
	host-python-hatch-vcs

HOST_PYTHON_ATTRS_DEPENDENCIES = \
	host-python-hatch-fancy-pypi-readme \
	host-python-hatch-vcs

$(eval $(python-package))
$(eval $(host-python-package))
