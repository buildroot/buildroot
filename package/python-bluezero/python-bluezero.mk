################################################################################
#
# python-bluezero
#
################################################################################

PYTHON_BLUEZERO_VERSION = 0.7.1
PYTHON_BLUEZERO_SOURCE = bluezero-$(PYTHON_BLUEZERO_VERSION).tar.gz
PYTHON_BLUEZERO_SITE = https://files.pythonhosted.org/packages/9a/66/d4a92869ed2afd9483a65aff200b2ba0ca4365429bc9a836c5803ab876a5
PYTHON_BLUEZERO_SETUP_TYPE = setuptools
PYTHON_BLUEZERO_LICENSE = MIT
PYTHON_BLUEZERO_LICENSE_FILES = LICENSE

$(eval $(python-package))
