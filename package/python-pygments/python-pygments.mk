################################################################################
#
# python-pygments
#
################################################################################

PYTHON_PYGMENTS_VERSION = 2.15.1
PYTHON_PYGMENTS_SOURCE = Pygments-$(PYTHON_PYGMENTS_VERSION).tar.gz
PYTHON_PYGMENTS_SITE = https://files.pythonhosted.org/packages/89/6b/2114e54b290824197006e41be3f9bbe1a26e9c39d1f5fa20a6d62945a0b3
PYTHON_PYGMENTS_LICENSE = BSD-2-Clause
PYTHON_PYGMENTS_LICENSE_FILES = LICENSE
PYTHON_PYGMENTS_CPE_ID_VENDOR = pygments
PYTHON_PYGMENTS_CPE_ID_PRODUCT = pygments
PYTHON_PYGMENTS_SETUP_TYPE = setuptools

$(eval $(python-package))
