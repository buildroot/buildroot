################################################################################
#
# python-rsa
#
################################################################################

PYTHON_RSA_VERSION = 4.7.2
PYTHON_RSA_SOURCE = rsa-$(PYTHON_RSA_VERSION).tar.gz
PYTHON_RSA_SITE = https://files.pythonhosted.org/packages/db/b5/475c45a58650b0580421746504b680cd2db4e81bc941e94ca53785250269
PYTHON_RSA_SETUP_TYPE = setuptools
PYTHON_RSA_LICENSE = Apache-2.0
PYTHON_RSA_LICENSE_FILES = LICENSE

$(eval $(python-package))
