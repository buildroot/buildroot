################################################################################
#
# python-argon2-cffi-bindings
#
################################################################################

PYTHON_ARGON2_CFFI_BINDINGS_VERSION = 25.1.0
PYTHON_ARGON2_CFFI_BINDINGS_SOURCE = argon2_cffi_bindings-$(PYTHON_ARGON2_CFFI_BINDINGS_VERSION).tar.gz
PYTHON_ARGON2_CFFI_BINDINGS_SITE = https://files.pythonhosted.org/packages/5c/2d/db8af0df73c1cf454f71b2bbe5e356b8c1f8041c979f505b3d3186e520a9
PYTHON_ARGON2_CFFI_BINDINGS_SETUP_TYPE = setuptools
PYTHON_ARGON2_CFFI_BINDINGS_LICENSE = MIT
PYTHON_ARGON2_CFFI_BINDINGS_LICENSE_FILES = LICENSE
PYTHON_ARGON2_CFFI_BINDINGS_DEPENDENCIES = \
	host-python-cffi \
	host-python-setuptools-scm \
	libargon2
PYTHON_ARGON2_CFFI_BINDINGS_ENV = ARGON2_CFFI_USE_SYSTEM=1

ifeq ($(BR2_X86_CPU_HAS_SSE2),y)
PYTHON_ARGON2_CFFI_BINDINGS_ENV += ARGON2_CFFI_USE_SSE2=1
else
PYTHON_ARGON2_CFFI_BINDINGS_ENV += ARGON2_CFFI_USE_SSE2=0
endif

$(eval $(python-package))
