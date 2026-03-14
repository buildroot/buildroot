################################################################################
#
# python-tomli
#
################################################################################

PYTHON_TOMLI_VERSION = 2.4.0
PYTHON_TOMLI_SOURCE = tomli-$(PYTHON_TOMLI_VERSION).tar.gz
PYTHON_TOMLI_SITE = https://files.pythonhosted.org/packages/82/30/31573e9457673ab10aa432461bee537ce6cef177667deca369efb79df071
PYTHON_TOMLI_LICENSE = MIT
PYTHON_TOMLI_LICENSE_FILES = LICENSE
PYTHON_TOMLI_SETUP_TYPE = flit

$(eval $(python-package))
$(eval $(host-python-package))
