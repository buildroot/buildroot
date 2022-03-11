################################################################################
#
# python-argon2-cffi
#
################################################################################

PYTHON_ARGON2_CFFI_VERSION = 21.3.0
PYTHON_ARGON2_CFFI_SOURCE = argon2-cffi-$(PYTHON_ARGON2_CFFI_VERSION).tar.gz
PYTHON_ARGON2_CFFI_SITE = https://files.pythonhosted.org/packages/3f/18/20bb5b6bf55e55d14558b57afc3d4476349ab90e0c43e60f27a7c2187289
PYTHON_ARGON2_CFFI_SETUP_TYPE = flit
PYTHON_ARGON2_CFFI_LICENSE = MIT
PYTHON_ARGON2_CFFI_LICENSE_FILES = LICENSE

$(eval $(python-package))
