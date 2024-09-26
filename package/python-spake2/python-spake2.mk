################################################################################
#
# python-spake2
#
################################################################################

PYTHON_SPAKE2_VERSION = 0.9
PYTHON_SPAKE2_SOURCE = spake2-$(PYTHON_SPAKE2_VERSION).tar.gz
PYTHON_SPAKE2_SITE = https://files.pythonhosted.org/packages/c5/4b/32ad65f8ff5c49254e218ccaae8fc16900cfc289954fb372686159ebe315
PYTHON_SPAKE2_SETUP_TYPE = setuptools
PYTHON_SPAKE2_LICENSE = MIT
PYTHON_SPAKE2_LICENSE_FILES = LICENSE

$(eval $(python-package))
