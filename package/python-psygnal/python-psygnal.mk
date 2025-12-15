################################################################################
#
# python-psygnal
#
################################################################################

PYTHON_PSYGNAL_VERSION = 0.15.0
PYTHON_PSYGNAL_SOURCE = psygnal-$(PYTHON_PSYGNAL_VERSION).tar.gz
PYTHON_PSYGNAL_SITE = https://files.pythonhosted.org/packages/5a/20/70430999aa609adb0601ec0f72bd23790a6e51a80ae6e7dc6621e6c5ee2a
PYTHON_PSYGNAL_SETUP_TYPE = hatch
PYTHON_PSYGNAL_LICENSE = BSD-3-Clause
PYTHON_PSYGNAL_LICENSE_FILES = LICENSE
PYTHON_PSYGNAL_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
