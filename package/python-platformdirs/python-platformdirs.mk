################################################################################
#
# python-platformdirs
#
################################################################################

PYTHON_PLATFORMDIRS_VERSION = 4.14.2
PYTHON_PLATFORMDIRS_SOURCE = platformdirs-$(PYTHON_PLATFORMDIRS_VERSION).tar.gz
PYTHON_PLATFORMDIRS_SITE = https://files.pythonhosted.org/packages/6e/4e/2684728d9f2c8c4110738dcadca7e0bed4b60c8dc68c40c2a9e0cf017900
PYTHON_PLATFORMDIRS_SETUP_TYPE = hatch
PYTHON_PLATFORMDIRS_LICENSE = MIT
PYTHON_PLATFORMDIRS_LICENSE_FILES = LICENSE
PYTHON_PLATFORMDIRS_DEPENDENCIES = \
	host-python-hatch-fancy-pypi-readme \
	host-python-hatch-vcs
HOST_PYTHON_PLATFORMDIRS_DEPENDENCIES = \
	host-python-hatch-fancy-pypi-readme \
	host-python-hatch-vcs

$(eval $(python-package))
$(eval $(host-python-package))
