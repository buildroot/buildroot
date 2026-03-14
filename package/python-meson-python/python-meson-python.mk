################################################################################
#
# python-meson-python
#
################################################################################

PYTHON_MESON_PYTHON_VERSION = 0.19.0
PYTHON_MESON_PYTHON_SOURCE = meson_python-$(PYTHON_MESON_PYTHON_VERSION).tar.gz
PYTHON_MESON_PYTHON_SITE = https://files.pythonhosted.org/packages/32/98/7fe5d1bf741c03c6eea04b6245737dbd79657d4f9200e82fcbb4cc12637b
PYTHON_MESON_PYTHON_SETUP_TYPE = pep517
PYTHON_MESON_PYTHON_LICENSE = MIT
PYTHON_MESON_PYTHON_LICENSE_FILES = LICENSE
HOST_PYTHON_MESON_PYTHON_DEPENDENCIES = \
	host-meson \
	host-patchelf \
	host-python-packaging \
	host-python-pyproject-metadata

$(eval $(host-python-package))
