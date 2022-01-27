################################################################################
#
# python-argon2-cffi-bindings
#
################################################################################

PYTHON_ARGON2_CFFI_BINDINGS_VERSION = 21.2.0
PYTHON_ARGON2_CFFI_BINDINGS_SOURCE = argon2-cffi-bindings-$(PYTHON_ARGON2_CFFI_BINDINGS_VERSION).tar.gz
PYTHON_ARGON2_CFFI_BINDINGS_SITE = https://files.pythonhosted.org/packages/b9/e9/184b8ccce6683b0aa2fbb7ba5683ea4b9c5763f1356347f1312c32e3c66e
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
