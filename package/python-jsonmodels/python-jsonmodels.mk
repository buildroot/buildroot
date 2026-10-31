################################################################################
#
# python-jsonmodels
#
################################################################################

PYTHON_JSONMODELS_VERSION = 2.9.0
PYTHON_JSONMODELS_SOURCE = jsonmodels-$(PYTHON_JSONMODELS_VERSION).tar.gz
PYTHON_JSONMODELS_SITE = https://files.pythonhosted.org/packages/8a/8e/134dfa6f8cafabfcf406835fced78ceb95d1433bff9b375e34ed08b2775b
PYTHON_JSONMODELS_SETUP_TYPE = hatch
PYTHON_JSONMODELS_LICENSE = BSD-3-Clause
PYTHON_JSONMODELS_LICENSE_FILES = LICENSE

$(eval $(python-package))
