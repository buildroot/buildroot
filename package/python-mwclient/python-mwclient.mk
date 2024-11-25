################################################################################
#
# python-mwclient
#
################################################################################

PYTHON_MWCLIENT_VERSION = 0.11.0
PYTHON_MWCLIENT_SOURCE = mwclient-$(PYTHON_MWCLIENT_VERSION).tar.gz
PYTHON_MWCLIENT_SITE = https://files.pythonhosted.org/packages/5e/b3/0f77b8838a22e99b9cb64aef15fb96a4a8315fe890dbe3bff6f8364e8940
PYTHON_MWCLIENT_LICENSE = MIT
PYTHON_MWCLIENT_LICENSE_FILES = LICENSE.md
PYTHON_MWCLIENT_SETUP_TYPE = setuptools

$(eval $(python-package))
