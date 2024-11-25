################################################################################
#
# python-psygnal
#
################################################################################

PYTHON_PSYGNAL_VERSION = 0.11.1
PYTHON_PSYGNAL_SOURCE = psygnal-$(PYTHON_PSYGNAL_VERSION).tar.gz
PYTHON_PSYGNAL_SITE = https://files.pythonhosted.org/packages/bc/b0/194cfbcb76dbf9c4a1c4271ccc825b38406d20fb7f95fd18320c28708800
PYTHON_PSYGNAL_SETUP_TYPE = hatch
PYTHON_PSYGNAL_LICENSE = BSD-3-Clause
PYTHON_PSYGNAL_LICENSE_FILES = LICENSE
PYTHON_PSYGNAL_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
