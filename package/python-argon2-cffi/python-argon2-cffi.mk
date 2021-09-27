################################################################################
#
# python-argon2-cffi
#
################################################################################

PYTHON_ARGON2_CFFI_VERSION = 21.1.0
PYTHON_ARGON2_CFFI_SOURCE = argon2-cffi-$(PYTHON_ARGON2_CFFI_VERSION).tar.gz
PYTHON_ARGON2_CFFI_SITE = https://files.pythonhosted.org/packages/7b/39/a26aaef5c3f0c6cfd67c80599b5b40a794fdab46f4ee3be925d71e2f9596
PYTHON_ARGON2_CFFI_SETUP_TYPE = setuptools
PYTHON_ARGON2_CFFI_LICENSE = MIT
PYTHON_ARGON2_CFFI_LICENSE_FILES = LICENSE
PYTHON_ARGON2_CFFI_DEPENDENCIES = host-python-cffi libargon2
PYTHON_ARGON2_CFFI_ENV = ARGON2_CFFI_USE_SYSTEM=1

ifeq ($(BR2_X86_CPU_HAS_SSE2),y)
PYTHON_ARGON2_CFFI_ENV += ARGON2_CFFI_USE_SSE2=1
else
PYTHON_ARGON2_CFFI_ENV += ARGON2_CFFI_USE_SSE2=0
endif

$(eval $(python-package))
