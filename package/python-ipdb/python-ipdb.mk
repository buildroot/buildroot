################################################################################
#
# python-ipdb
#
################################################################################

PYTHON_IPDB_VERSION = 0.13.11
PYTHON_IPDB_SOURCE = ipdb-$(PYTHON_IPDB_VERSION).tar.gz
PYTHON_IPDB_SITE = https://files.pythonhosted.org/packages/23/b2/c972cc266b0ba8508b42dab7f5dea1be03ea32213258441bf1b00baca555
PYTHON_IPDB_SETUP_TYPE = setuptools
PYTHON_IPDB_LICENSE = BSD-3-Clause
PYTHON_IPDB_LICENSE_FILES = COPYING.txt

$(eval $(python-package))
