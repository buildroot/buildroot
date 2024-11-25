################################################################################
#
# python-slob
#
################################################################################

PYTHON_SLOB_VERSION = c21d695707db7d2fe4ec7ec27a018bb7b0fcc209
PYTHON_SLOB_SITE = $(call github,itkach,slob,$(PYTHON_SLOB_VERSION))
PYTHON_SLOB_LICENSE = GPL-3.0
PYTHON_SLOB_LICENSE_FILES = LICENSE
PYTHON_SLOB_SETUP_TYPE = setuptools

$(eval $(python-package))
