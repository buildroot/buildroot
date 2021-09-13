################################################################################
#
# python3-cheetah
#
################################################################################

# Please keep in sync with
# package/python-cheetah/python-cheetah.mk
PYTHON3_CHEETAH_VERSION = 3.2.6.post2
PYTHON3_CHEETAH_SOURCE = Cheetah3-$(PYTHON3_CHEETAH_VERSION).tar.gz
PYTHON3_CHEETAH_SITE = https://files.pythonhosted.org/packages/c0/97/c3fa47e223207e6ca6b501a954c5c959ed3e99f2a1ceec9918238ce38418
PYTHON3_CHEETAH_LICENSE = MIT
PYTHON3_CHEETAH_LICENSE_FILES = LICENSE
PYTHON3_CHEETAH_SETUP_TYPE = setuptools
HOST_PYTHON3_CHEETAH_DL_SUBDIR = python-cheetah
HOST_PYTHON3_CHEETAH_NEEDS_HOST_PYTHON = python3

$(eval $(host-python-package))
