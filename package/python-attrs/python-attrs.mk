################################################################################
#
# python-attrs
#
################################################################################

PYTHON_ATTRS_VERSION = 24.2.0
PYTHON_ATTRS_SOURCE = attrs-$(PYTHON_ATTRS_VERSION).tar.gz
PYTHON_ATTRS_SITE = https://files.pythonhosted.org/packages/fc/0f/aafca9af9315aee06a89ffde799a10a582fe8de76c563ee80bbcdc08b3fb
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
