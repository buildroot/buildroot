################################################################################
#
# python-certifi
#
################################################################################

PYTHON_CERTIFI_VERSION = 2022.12.7
PYTHON_CERTIFI_SOURCE = certifi-$(PYTHON_CERTIFI_VERSION).tar.gz
PYTHON_CERTIFI_SITE = https://files.pythonhosted.org/packages/37/f7/2b1b0ec44fdc30a3d31dfebe52226be9ddc40cd6c0f34ffc8923ba423b69
PYTHON_CERTIFI_SETUP_TYPE = setuptools
PYTHON_CERTIFI_LICENSE = ISC (Python code), MPL-2.0 (cacert.pem)
PYTHON_CERTIFI_LICENSE_FILES = LICENSE

$(eval $(python-package))
$(eval $(host-python-package))
