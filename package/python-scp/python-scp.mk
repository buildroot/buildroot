################################################################################
#
# python-scp
#
################################################################################

PYTHON_SCP_VERSION = 0.16.2
PYTHON_SCP_SOURCE = scp-$(PYTHON_SCP_VERSION).tar.gz
PYTHON_SCP_SITE = https://files.pythonhosted.org/packages/38/c3/4d0230664b7c505ba2fa7bf9fe4bee83f6f1fa195e865ad7f92b12917e59
PYTHON_SCP_SETUP_TYPE = setuptools
PYTHON_SCP_LICENSE = LGPL-2.1+
PYTHON_SCP_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
