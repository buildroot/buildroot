################################################################################
#
# python-patch-ng
#
################################################################################

PYTHON_PATCH_NG_VERSION = 1.19.0
PYTHON_PATCH_NG_SOURCE = patch-ng-$(PYTHON_PATCH_NG_VERSION).tar.gz
PYTHON_PATCH_NG_SITE = https://files.pythonhosted.org/packages/65/bb/ebd7c6058dcfbf634986f9a8b3fb638f3269501c73701a48b7530042da5b
PYTHON_PATCH_NG_SETUP_TYPE = setuptools
PYTHON_PATCH_NG_LICENSE = MIT
PYTHON_PATCH_NG_LICENSE_FILES = LICENSE

$(eval $(python-package))
$(eval $(host-python-package))
