################################################################################
#
# python-platformdirs
#
################################################################################

PYTHON_PLATFORMDIRS_VERSION = 4.13.4
PYTHON_PLATFORMDIRS_SOURCE = platformdirs-$(PYTHON_PLATFORMDIRS_VERSION).tar.gz
PYTHON_PLATFORMDIRS_SITE = https://files.pythonhosted.org/packages/b7/89/dfd269de936e76319cf27787d9eaaca513491f635d49b0fbe7cdb6d3bf6f
PYTHON_PLATFORMDIRS_SETUP_TYPE = hatch
PYTHON_PLATFORMDIRS_LICENSE = MIT
PYTHON_PLATFORMDIRS_LICENSE_FILES = LICENSE
PYTHON_PLATFORMDIRS_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
