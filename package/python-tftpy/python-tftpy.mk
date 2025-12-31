################################################################################
#
# python-tftpy
#
################################################################################

PYTHON_TFTPY_VERSION = 0.8.6
PYTHON_TFTPY_SOURCE = tftpy-$(PYTHON_TFTPY_VERSION).tar.gz
PYTHON_TFTPY_SITE = https://files.pythonhosted.org/packages/68/7a/15a01d67184aa855e07eac08bfd514e008027ff198b32274f7657d8368ad
PYTHON_TFTPY_LICENSE = MIT
PYTHON_TFTPY_LICENSE_FILES = LICENSE
PYTHON_TFTPY_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
