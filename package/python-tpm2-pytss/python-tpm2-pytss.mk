################################################################################
#
# python-tpm2-pytss
#
################################################################################

PYTHON_TPM2_PYTSS_VERSION = 2.2.1
PYTHON_TPM2_PYTSS_SOURCE = tpm2-pytss-$(PYTHON_TPM2_PYTSS_VERSION).tar.gz
PYTHON_TPM2_PYTSS_SITE = https://files.pythonhosted.org/packages/13/e5/8d4a9ac91579c741ec9fb63befcf6577107f22f3508c364fd53e277d7237
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
