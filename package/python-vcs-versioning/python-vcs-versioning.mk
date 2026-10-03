################################################################################
#
# python-vcs-versioning
#
################################################################################

PYTHON_VCS_VERSIONING_VERSION = 2.5.0
PYTHON_VCS_VERSIONING_SOURCE = vcs_versioning-$(PYTHON_VCS_VERSIONING_VERSION).tar.gz
PYTHON_VCS_VERSIONING_SITE = https://files.pythonhosted.org/packages/6f/a0/6977bb418312ad30f27e522c5040604d4bbf7e40ccd5a11d333afe549354
PYTHON_VCS_VERSIONING_SETUP_TYPE = setuptools
PYTHON_VCS_VERSIONING_LICENSE = MIT
PYTHON_VCS_VERSIONING_LICENSE_FILES = LICENSE.txt
HOST_PYTHON_VCS_VERSIONING_DEPENDENCIES = host-python-packaging

$(eval $(host-python-package))
