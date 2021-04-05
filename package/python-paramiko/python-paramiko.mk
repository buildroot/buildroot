################################################################################
#
# python-paramiko
#
################################################################################

PYTHON_PARAMIKO_VERSION = 2.7.2
PYTHON_PARAMIKO_SOURCE = paramiko-$(PYTHON_PARAMIKO_VERSION).tar.gz
PYTHON_PARAMIKO_SITE = https://files.pythonhosted.org/packages/cf/a1/20d00ce559a692911f11cadb7f94737aca3ede1c51de16e002c7d3a888e0
PYTHON_PARAMIKO_SETUP_TYPE = setuptools
PYTHON_PARAMIKO_LICENSE = LGPL-2.1+
PYTHON_PARAMIKO_LICENSE_FILES = LICENSE
PYTHON_PARAMIKO_CPE_ID_VENDOR = paramiko
PYTHON_PARAMIKO_CPE_ID_PRODUCT = paramiko

$(eval $(python-package))
