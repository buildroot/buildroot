################################################################################
#
# python-tpm2-pytss
#
################################################################################

PYTHON_TPM2_PYTSS_VERSION = 3.0.0
PYTHON_TPM2_PYTSS_SOURCE = tpm2_pytss-$(PYTHON_TPM2_PYTSS_VERSION).tar.gz
PYTHON_TPM2_PYTSS_SITE = https://files.pythonhosted.org/packages/39/47/7d7089c88e5c73bdef6ca85d6bdb00cdfd655fb59f9cb2b1011557ce7533
PYTHON_TPM2_PYTSS_SETUP_TYPE = setuptools
PYTHON_TPM2_PYTSS_LICENSE = BSD-2-Clause
PYTHON_TPM2_PYTSS_LICENSE_FILES = LICENSE

PYTHON_TPM2_PYTSS_DEPENDENCIES = host-pkgconf \
	host-python-asn1crypto \
	host-python-cffi \
	host-python-cryptography \
	host-python-pkgconfig \
	host-python-pycparser \
	host-python-setuptools-scm \
	tpm2-tss

$(eval $(python-package))
