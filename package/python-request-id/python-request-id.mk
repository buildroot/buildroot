################################################################################
#
# python-request-id
#
################################################################################

PYTHON_REQUEST_ID_VERSION = 1.0.1
PYTHON_REQUEST_ID_SOURCE = request-id-$(PYTHON_REQUEST_ID_VERSION).tar.gz
PYTHON_REQUEST_ID_SITE = https://files.pythonhosted.org/packages/9b/b3/30617b85b1766b6a804f2b8abc0ca7496f6349236f7eec28cb42687ca8e3
PYTHON_REQUEST_ID_SETUP_TYPE = setuptools
PYTHON_REQUEST_ID_LICENSE = MIT
PYTHON_REQUEST_ID_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
