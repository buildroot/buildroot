################################################################################
#
# python-psygnal
#
################################################################################

PYTHON_PSYGNAL_VERSION = 0.15.1
PYTHON_PSYGNAL_SOURCE = psygnal-$(PYTHON_PSYGNAL_VERSION).tar.gz
PYTHON_PSYGNAL_SITE = https://files.pythonhosted.org/packages/4e/79/20c3e23e75272e9ddf018097cf872ab088bccba978888472656629efa4a3
PYTHON_PSYGNAL_SETUP_TYPE = hatch
PYTHON_PSYGNAL_LICENSE = BSD-3-Clause
PYTHON_PSYGNAL_LICENSE_FILES = LICENSE
PYTHON_PSYGNAL_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
