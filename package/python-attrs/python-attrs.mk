################################################################################
#
# python-attrs
#
################################################################################

PYTHON_ATTRS_VERSION = 25.1.0
PYTHON_ATTRS_SOURCE = attrs-$(PYTHON_ATTRS_VERSION).tar.gz
PYTHON_ATTRS_SITE = https://files.pythonhosted.org/packages/49/7c/fdf464bcc51d23881d110abd74b512a42b3d5d376a55a831b44c603ae17f
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
