################################################################################
#
# python-platformdirs
#
################################################################################

PYTHON_PLATFORMDIRS_VERSION = 4.12.3
PYTHON_PLATFORMDIRS_SOURCE = platformdirs-$(PYTHON_PLATFORMDIRS_VERSION).tar.gz
PYTHON_PLATFORMDIRS_SITE = https://files.pythonhosted.org/packages/42/23/4a86fc741c38c5b69792a4ef954b281afa69bea9f083f881de1b0d23bc07
PYTHON_PLATFORMDIRS_SETUP_TYPE = hatch
PYTHON_PLATFORMDIRS_LICENSE = MIT
PYTHON_PLATFORMDIRS_LICENSE_FILES = LICENSE
PYTHON_PLATFORMDIRS_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
