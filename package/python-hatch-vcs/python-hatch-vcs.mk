################################################################################
#
# python-hatch-vcs
#
################################################################################

PYTHON_HATCH_VCS_VERSION = 0.5.0
PYTHON_HATCH_VCS_SOURCE = hatch_vcs-$(PYTHON_HATCH_VCS_VERSION).tar.gz
PYTHON_HATCH_VCS_SITE = https://files.pythonhosted.org/packages/6b/b0/4cc743d38adbee9d57d786fa496ed1daadb17e48589b6da8fa55717a0746
PYTHON_HATCH_VCS_LICENSE = MIT
PYTHON_HATCH_VCS_LICENSE_FILES = LICENSE.txt
PYTHON_HATCH_VCS_SETUP_TYPE = hatch
HOST_PYTHON_HATCH_VCS_DEPENDENCIES = host-python-setuptools-scm

$(eval $(host-python-package))
