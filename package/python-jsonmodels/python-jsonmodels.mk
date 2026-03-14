################################################################################
#
# python-jsonmodels
#
################################################################################

PYTHON_JSONMODELS_VERSION = 2.8.0
PYTHON_JSONMODELS_SOURCE = jsonmodels-$(PYTHON_JSONMODELS_VERSION).tar.gz
PYTHON_JSONMODELS_SITE = https://files.pythonhosted.org/packages/04/85/0e02cbc656ef7f0f5d3db13be5b622c231bf55bbad6a8c4612ce95fcb8cf
PYTHON_JSONMODELS_SETUP_TYPE = hatch
PYTHON_JSONMODELS_LICENSE = BSD-3-Clause
PYTHON_JSONMODELS_LICENSE_FILES = LICENSE

$(eval $(python-package))
