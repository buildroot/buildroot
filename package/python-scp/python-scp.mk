################################################################################
#
# python-scp
#
################################################################################

PYTHON_SCP_VERSION = 0.16.0
PYTHON_SCP_SOURCE = scp-$(PYTHON_SCP_VERSION).tar.gz
PYTHON_SCP_SITE = https://files.pythonhosted.org/packages/7f/e1/34634a89f100fcf4f014aca65621e701c5b9053cec62b6386866e3f015d5
PYTHON_SCP_SETUP_TYPE = setuptools
PYTHON_SCP_LICENSE = LGPL-2.1+
PYTHON_SCP_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
