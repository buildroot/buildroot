################################################################################
#
# python-scp
#
################################################################################

PYTHON_SCP_VERSION = 0.16.1
PYTHON_SCP_SOURCE = scp-$(PYTHON_SCP_VERSION).tar.gz
PYTHON_SCP_SITE = https://files.pythonhosted.org/packages/f8/35/fcef45d52d76a6dc70778c11eea719ff0ab550594bc51e55e66d28b5f424
PYTHON_SCP_SETUP_TYPE = setuptools
PYTHON_SCP_LICENSE = LGPL-2.1+
PYTHON_SCP_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
