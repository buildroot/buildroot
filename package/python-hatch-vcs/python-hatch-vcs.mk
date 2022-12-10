################################################################################
#
# python-hatch-vcs
#
################################################################################

PYTHON_HATCH_VCS_VERSION = 0.3.0
PYTHON_HATCH_VCS_SOURCE = hatch_vcs-$(PYTHON_HATCH_VCS_VERSION).tar.gz
PYTHON_HATCH_VCS_SITE = https://files.pythonhosted.org/packages/04/33/b68d68e532392d938472d16a03e4ce0ccd749ea31b42d18f8baa6547cbfd
PYTHON_HATCH_VCS_LICENSE = MIT
PYTHON_HATCH_VCS_LICENSE_FILES = LICENSE.txt
PYTHON_HATCH_VCS_SETUP_TYPE = pep517
HOST_PYTHON_HATCH_VCS_DEPENDENCIES = \
	host-python-hatchling \
	host-python-setuptools-scm

$(eval $(host-python-package))
