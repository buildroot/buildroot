################################################################################
#
# python-expandvars
#
################################################################################

PYTHON_EXPANDVARS_VERSION = 0.12.0
PYTHON_EXPANDVARS_SOURCE = expandvars-$(PYTHON_EXPANDVARS_VERSION).tar.gz
PYTHON_EXPANDVARS_SITE = https://files.pythonhosted.org/packages/2b/a5/46d1f58edcae1d632fafdfee313e378240e002ae45d26502bac938bd8751
PYTHON_EXPANDVARS_SETUP_TYPE = pep517
PYTHON_EXPANDVARS_LICENSE = MIT
PYTHON_EXPANDVARS_LICENSE_FILES = LICENSE
HOST_PYTHON_EXPANDVARS_DEPENDENCIES = host-python-hatchling

$(eval $(host-python-package))
