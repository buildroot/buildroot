################################################################################
#
# python-meson-python
#
################################################################################

PYTHON_MESON_PYTHON_VERSION = 0.15.0
PYTHON_MESON_PYTHON_SOURCE = meson_python-$(PYTHON_MESON_PYTHON_VERSION).tar.gz
PYTHON_MESON_PYTHON_SITE = https://files.pythonhosted.org/packages/a2/3b/276b596824a0820987fdcc7721618453b4f9a8305fe20b611a00ac3f948e
PYTHON_MESON_PYTHON_SETUP_TYPE = pep517
PYTHON_MESON_PYTHON_LICENSE = MIT
PYTHON_MESON_PYTHON_LICENSE_FILES = LICENSE
HOST_PYTHON_MESON_PYTHON_DEPENDENCIES = \
	host-meson \
	host-patchelf \
	host-python-pyproject-metadata

$(eval $(host-python-package))
