################################################################################
#
# python-paramiko
#
################################################################################

PYTHON_PARAMIKO_VERSION = 2.11.0
PYTHON_PARAMIKO_SOURCE = paramiko-$(PYTHON_PARAMIKO_VERSION).tar.gz
PYTHON_PARAMIKO_SITE = https://files.pythonhosted.org/packages/1d/08/3b8d8f1b4ec212c17429c2f3ff55b7f2237a1ad0c954972e39c8f0ac394c
PYTHON_PARAMIKO_SETUP_TYPE = setuptools
PYTHON_PARAMIKO_LICENSE = LGPL-2.1+
PYTHON_PARAMIKO_LICENSE_FILES = LICENSE
PYTHON_PARAMIKO_CPE_ID_VENDOR = paramiko
PYTHON_PARAMIKO_CPE_ID_PRODUCT = paramiko

$(eval $(python-package))
