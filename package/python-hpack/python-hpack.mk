################################################################################
#
# python-hpack
#
################################################################################

PYTHON_HPACK_VERSION = 4.0.0
PYTHON_HPACK_SOURCE = hpack-$(PYTHON_HPACK_VERSION).tar.gz
PYTHON_HPACK_SITE = https://files.pythonhosted.org/packages/3e/9b/fda93fb4d957db19b0f6b370e79d586b3e8528b20252c729c476a2c02954
PYTHON_HPACK_SETUP_TYPE = setuptools
PYTHON_HPACK_LICENSE = MIT
PYTHON_HPACK_LICENSE_FILES = LICENSE

$(eval $(python-package))
