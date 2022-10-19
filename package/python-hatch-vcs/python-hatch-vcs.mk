################################################################################
#
# python-hatch-vcs
#
################################################################################

PYTHON_HATCH_VCS_VERSION = 0.2.0
PYTHON_HATCH_VCS_SOURCE = hatch_vcs-$(PYTHON_HATCH_VCS_VERSION).tar.gz
PYTHON_HATCH_VCS_SITE = https://files.pythonhosted.org/packages/ac/13/b3d83564c0cc0f1d45b4ea2a78b87b383a8165797613fedf11f1a7e49b48
PYTHON_HATCH_VCS_LICENSE = MIT
PYTHON_HATCH_VCS_LICENSE_FILES = LICENSE.txt
PYTHON_HATCH_VCS_SETUP_TYPE = pep517
HOST_PYTHON_HATCH_VCS_DEPENDENCIES = \
	host-python-hatchling \
	host-python-setuptools-scm

$(eval $(host-python-package))
