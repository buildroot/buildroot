################################################################################
#
# python-vcs-versioning
#
################################################################################

PYTHON_VCS_VERSIONING_VERSION = 2.6.0
PYTHON_VCS_VERSIONING_SOURCE = vcs_versioning-$(PYTHON_VCS_VERSIONING_VERSION).tar.gz
PYTHON_VCS_VERSIONING_SITE = https://files.pythonhosted.org/packages/ad/e7/2a691db7d076b75d099fdba1a14cd966931f2aeb591e77f6d22f15097326
PYTHON_VCS_VERSIONING_SETUP_TYPE = setuptools
PYTHON_VCS_VERSIONING_LICENSE = MIT
PYTHON_VCS_VERSIONING_LICENSE_FILES = LICENSE.txt
HOST_PYTHON_VCS_VERSIONING_DEPENDENCIES = host-python-packaging

$(eval $(host-python-package))
