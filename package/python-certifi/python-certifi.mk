################################################################################
#
# python-certifi
#
################################################################################

PYTHON_CERTIFI_VERSION = 2022.9.14
PYTHON_CERTIFI_SOURCE = certifi-$(PYTHON_CERTIFI_VERSION).tar.gz
PYTHON_CERTIFI_SITE = https://files.pythonhosted.org/packages/ca/48/88ec470f8b68319b6782ca3a0570789886ad5ca24c1af2f3771699135baa
PYTHON_CERTIFI_SETUP_TYPE = setuptools
PYTHON_CERTIFI_LICENSE = ISC (Python code), MPL-2.0 (cacert.pem)
PYTHON_CERTIFI_LICENSE_FILES = LICENSE

$(eval $(python-package))
$(eval $(host-python-package))
