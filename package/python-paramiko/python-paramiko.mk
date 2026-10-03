################################################################################
#
# python-paramiko
#
################################################################################

PYTHON_PARAMIKO_VERSION = 5.0.0
PYTHON_PARAMIKO_SOURCE = paramiko-$(PYTHON_PARAMIKO_VERSION).tar.gz
PYTHON_PARAMIKO_SITE = https://files.pythonhosted.org/packages/62/93/dcc25d52f49022ae6175d15e6bd751f1acc99b98bc61fc55e5155a7be2e7
PYTHON_PARAMIKO_SETUP_TYPE = setuptools
PYTHON_PARAMIKO_LICENSE = LGPL-2.1+
PYTHON_PARAMIKO_LICENSE_FILES = LICENSE
PYTHON_PARAMIKO_CPE_ID_VENDOR = paramiko
PYTHON_PARAMIKO_CPE_ID_PRODUCT = paramiko

$(eval $(python-package))
