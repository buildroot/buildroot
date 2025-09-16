################################################################################
#
# python-expandvars
#
################################################################################

PYTHON_EXPANDVARS_VERSION = 1.1.2
PYTHON_EXPANDVARS_SOURCE = expandvars-$(PYTHON_EXPANDVARS_VERSION).tar.gz
PYTHON_EXPANDVARS_SITE = https://files.pythonhosted.org/packages/9c/64/a9d8ea289d663a44b346203a24bf798507463db1e76679eaa72ee6de1c7a
PYTHON_EXPANDVARS_SETUP_TYPE = hatch
PYTHON_EXPANDVARS_LICENSE = MIT
PYTHON_EXPANDVARS_LICENSE_FILES = LICENSE

$(eval $(host-python-package))
