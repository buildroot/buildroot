################################################################################
#
# python-spake2
#
################################################################################

PYTHON_SPAKE2_VERSION = 0.8
PYTHON_SPAKE2_SOURCE = spake2-$(PYTHON_SPAKE2_VERSION).tar.gz
PYTHON_SPAKE2_SITE = https://files.pythonhosted.org/packages/60/0b/bb5eca8e18c38a10b1c207bbe6103df091e5cf7b3e5fdc0efbcad7b85b60
PYTHON_SPAKE2_SETUP_TYPE = setuptools
PYTHON_SPAKE2_LICENSE = MIT
PYTHON_SPAKE2_LICENSE_FILES = LICENSE

$(eval $(python-package))
