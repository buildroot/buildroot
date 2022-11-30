################################################################################
#
# python-ipdb
#
################################################################################

PYTHON_IPDB_VERSION = 0.13.9
PYTHON_IPDB_SOURCE = ipdb-$(PYTHON_IPDB_VERSION).tar.gz
PYTHON_IPDB_SITE = https://files.pythonhosted.org/packages/fc/56/9f67dcd4a4b9960373173a31be1b8c47fe351a1c9385677a7bdd82810e57
PYTHON_IPDB_SETUP_TYPE = setuptools
PYTHON_IPDB_LICENSE = BSD-3-Clause
PYTHON_IPDB_LICENSE_FILES = COPYING.txt

$(eval $(python-package))
