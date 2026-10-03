################################################################################
#
# python-yatl
#
################################################################################

PYTHON_YATL_VERSION = 20260805.1
PYTHON_YATL_SOURCE = yatl-$(PYTHON_YATL_VERSION).tar.gz
PYTHON_YATL_SITE = https://files.pythonhosted.org/packages/33/bf/5456f2fa12811b4ce4dd82741ad781d834ff4f4865b75f775e50c3e9ac3e
PYTHON_YATL_SETUP_TYPE = setuptools
PYTHON_YATL_LICENSE = BSD-3-Clause
PYTHON_YATL_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
$(eval $(host-python-package))
