################################################################################
#
# python-meson-python
#
################################################################################

PYTHON_MESON_PYTHON_VERSION = 0.22.0
PYTHON_MESON_PYTHON_SOURCE = meson_python-$(PYTHON_MESON_PYTHON_VERSION).tar.gz
PYTHON_MESON_PYTHON_SITE = https://files.pythonhosted.org/packages/82/14/1bafca9db7691ff05767570686cd775bddec57c7358e78504cbfd35ec996
PYTHON_MESON_PYTHON_SETUP_TYPE = pep517
PYTHON_MESON_PYTHON_LICENSE = MIT
PYTHON_MESON_PYTHON_LICENSE_FILES = LICENSE
HOST_PYTHON_MESON_PYTHON_DEPENDENCIES = \
	host-meson \
	host-patchelf \
	host-python-packaging \
	host-python-pyproject-metadata

$(eval $(host-python-package))
