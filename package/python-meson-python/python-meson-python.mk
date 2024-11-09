################################################################################
#
# python-meson-python
#
################################################################################

PYTHON_MESON_PYTHON_VERSION = 0.17.1
PYTHON_MESON_PYTHON_SOURCE = meson_python-$(PYTHON_MESON_PYTHON_VERSION).tar.gz
PYTHON_MESON_PYTHON_SITE = https://files.pythonhosted.org/packages/67/66/91d242ea8dd1729addd36069318ba2cd03874872764f316c3bb51b633ed2
PYTHON_MESON_PYTHON_SETUP_TYPE = pep517
PYTHON_MESON_PYTHON_LICENSE = MIT
PYTHON_MESON_PYTHON_LICENSE_FILES = LICENSE
HOST_PYTHON_MESON_PYTHON_DEPENDENCIES = \
	host-meson \
	host-patchelf \
	host-python-packaging \
	host-python-pyproject-metadata

$(eval $(host-python-package))
