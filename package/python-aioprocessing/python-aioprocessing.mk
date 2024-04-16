################################################################################
#
# python-aioprocessing
#
################################################################################

PYTHON_AIOPROCESSING_VERSION = 2.0.1
PYTHON_AIOPROCESSING_SOURCE = aioprocessing-$(PYTHON_AIOPROCESSING_VERSION).tar.gz
PYTHON_AIOPROCESSING_SITE = https://files.pythonhosted.org/packages/4d/85/9a75151e7049bf144c01384279201d82d99484bd658f8e6fb013552d8724
PYTHON_AIOPROCESSING_SETUP_TYPE = flit
PYTHON_AIOPROCESSING_LICENSE = BSD-2-Clause
PYTHON_AIOPROCESSING_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
