################################################################################
#
# python-meson-python
#
################################################################################

PYTHON_MESON_PYTHON_VERSION = 0.18.0
PYTHON_MESON_PYTHON_SOURCE = meson_python-$(PYTHON_MESON_PYTHON_VERSION).tar.gz
PYTHON_MESON_PYTHON_SITE = https://files.pythonhosted.org/packages/26/bd/fdb26366443620f1a8a4d4ec7bfa37d1fbbe7bf737b257c205bbcf95ba95
PYTHON_MESON_PYTHON_SETUP_TYPE = pep517
PYTHON_MESON_PYTHON_LICENSE = MIT
PYTHON_MESON_PYTHON_LICENSE_FILES = LICENSE
HOST_PYTHON_MESON_PYTHON_DEPENDENCIES = \
	host-meson \
	host-patchelf \
	host-python-packaging \
	host-python-pyproject-metadata

$(eval $(host-python-package))
