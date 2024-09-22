################################################################################
#
# python-tpm2-pytss
#
################################################################################

PYTHON_TPM2_PYTSS_VERSION = 2.3.0
PYTHON_TPM2_PYTSS_SOURCE = tpm2-pytss-$(PYTHON_TPM2_PYTSS_VERSION).tar.gz
PYTHON_TPM2_PYTSS_SITE = https://files.pythonhosted.org/packages/07/1f/0f2521440e330342ef757a6605b61e1dbf5fe47fd97397c6e5f02791d520
PYTHON_TPM2_PYTSS_SETUP_TYPE = setuptools
PYTHON_TPM2_PYTSS_LICENSE = BSD-2-Clause
PYTHON_TPM2_PYTSS_LICENSE_FILES = LICENSE

PYTHON_TPM2_PYTSS_DEPENDENCIES = host-pkgconf \
	host-python-asn1crypto \
	host-python-cffi \
	host-python-cryptography \
	host-python-pkgconfig \
	host-python-pycparser \
	tpm2-tss

$(eval $(python-package))
