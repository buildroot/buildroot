################################################################################
#
# python-gitdb2
#
################################################################################

PYTHON_GITDB2_VERSION = 4.0.12
PYTHON_GITDB2_SOURCE = gitdb-$(PYTHON_GITDB2_VERSION).tar.gz
PYTHON_GITDB2_SITE = https://files.pythonhosted.org/packages/72/94/63b0fc47eb32792c7ba1fe1b694daec9a63620db1e313033d18140c2320a
PYTHON_GITDB2_SETUP_TYPE = setuptools
PYTHON_GITDB2_LICENSE = BSD-3-Clause
PYTHON_GITDB2_LICENSE_FILES = LICENSE

$(eval $(python-package))
