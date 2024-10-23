################################################################################
#
# python-argon2-cffi
#
################################################################################

PYTHON_ARGON2_CFFI_VERSION = 23.1.0
PYTHON_ARGON2_CFFI_SOURCE = argon2_cffi-$(PYTHON_ARGON2_CFFI_VERSION).tar.gz
PYTHON_ARGON2_CFFI_SITE = https://files.pythonhosted.org/packages/31/fa/57ec2c6d16ecd2ba0cf15f3c7d1c3c2e7b5fcb83555ff56d7ab10888ec8f
PYTHON_ARGON2_CFFI_SETUP_TYPE = hatch
PYTHON_ARGON2_CFFI_LICENSE = MIT
PYTHON_ARGON2_CFFI_LICENSE_FILES = LICENSE
PYTHON_ARGON2_CFFI_DEPENDENCIES = \
	host-python-hatch-fancy-pypi-readme \
	host-python-hatch-vcs

$(eval $(python-package))
