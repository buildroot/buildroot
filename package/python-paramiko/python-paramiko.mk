################################################################################
#
# python-paramiko
#
################################################################################

PYTHON_PARAMIKO_VERSION = 3.3.1
PYTHON_PARAMIKO_SOURCE = paramiko-$(PYTHON_PARAMIKO_VERSION).tar.gz
PYTHON_PARAMIKO_SITE = https://files.pythonhosted.org/packages/44/03/158ae1dcb950bd96f04038502238159e116fafb27addf5df1ba35068f2d6
PYTHON_PARAMIKO_SETUP_TYPE = setuptools
PYTHON_PARAMIKO_LICENSE = LGPL-2.1+
PYTHON_PARAMIKO_LICENSE_FILES = LICENSE
PYTHON_PARAMIKO_CPE_ID_VENDOR = paramiko
PYTHON_PARAMIKO_CPE_ID_PRODUCT = paramiko

$(eval $(python-package))
