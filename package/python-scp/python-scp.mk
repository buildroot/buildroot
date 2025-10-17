################################################################################
#
# python-scp
#
################################################################################

PYTHON_SCP_VERSION = 0.15.0
PYTHON_SCP_SOURCE = scp-$(PYTHON_SCP_VERSION).tar.gz
PYTHON_SCP_SITE = https://files.pythonhosted.org/packages/d6/1c/d213e1c6651d0bd37636b21b1ba9b895f276e8057f882c9f944931e4f002
PYTHON_SCP_SETUP_TYPE = setuptools
PYTHON_SCP_LICENSE = LGPL-2.1+
PYTHON_SCP_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
