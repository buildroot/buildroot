################################################################################
#
# python-hatch-vcs
#
################################################################################

PYTHON_HATCH_VCS_VERSION = 0.4.0
PYTHON_HATCH_VCS_SOURCE = hatch_vcs-$(PYTHON_HATCH_VCS_VERSION).tar.gz
PYTHON_HATCH_VCS_SITE = https://files.pythonhosted.org/packages/f5/c9/54bb4fa27b4e4a014ef3bb17710cdf692b3aa2cbc7953da885f1bf7e06ea
PYTHON_HATCH_VCS_LICENSE = MIT
PYTHON_HATCH_VCS_LICENSE_FILES = LICENSE.txt
PYTHON_HATCH_VCS_SETUP_TYPE = hatch
HOST_PYTHON_HATCH_VCS_DEPENDENCIES = host-python-setuptools-scm

$(eval $(host-python-package))
