################################################################################
#
# python-attrs
#
################################################################################

PYTHON_ATTRS_VERSION = 25.4.0
PYTHON_ATTRS_SOURCE = attrs-$(PYTHON_ATTRS_VERSION).tar.gz
PYTHON_ATTRS_SITE = https://files.pythonhosted.org/packages/6b/5c/685e6633917e101e5dcb62b9dd76946cbb57c26e133bae9e0cd36033c0a9
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
