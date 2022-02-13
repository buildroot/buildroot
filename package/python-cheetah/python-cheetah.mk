################################################################################
#
# python-cheetah
#
################################################################################

PYTHON_CHEETAH_VERSION = 3.2.6.post2
PYTHON_CHEETAH_SOURCE = Cheetah3-$(PYTHON_CHEETAH_VERSION).tar.gz
PYTHON_CHEETAH_SITE = https://files.pythonhosted.org/packages/c0/97/c3fa47e223207e6ca6b501a954c5c959ed3e99f2a1ceec9918238ce38418
PYTHON_CHEETAH_LICENSE = MIT
PYTHON_CHEETAH_LICENSE_FILES = LICENSE
PYTHON_CHEETAH_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
