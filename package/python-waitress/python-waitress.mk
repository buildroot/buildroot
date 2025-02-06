################################################################################
#
# python-waitress
#
################################################################################

PYTHON_WAITRESS_VERSION = 3.0.2
PYTHON_WAITRESS_SOURCE = waitress-$(PYTHON_WAITRESS_VERSION).tar.gz
PYTHON_WAITRESS_SITE = https://files.pythonhosted.org/packages/bf/cb/04ddb054f45faa306a230769e868c28b8065ea196891f09004ebace5b184
PYTHON_WAITRESS_SETUP_TYPE = setuptools
PYTHON_WAITRESS_LICENSE = ZPL-2.1
PYTHON_WAITRESS_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
