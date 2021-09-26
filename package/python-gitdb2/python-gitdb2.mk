################################################################################
#
# python-gitdb2
#
################################################################################

PYTHON_GITDB2_VERSION = 4.0.7
PYTHON_GITDB2_SOURCE = gitdb-$(PYTHON_GITDB2_VERSION).tar.gz
PYTHON_GITDB2_SITE = https://files.pythonhosted.org/packages/34/fe/9265459642ab6e29afe734479f94385870e8702e7f892270ed6e52dd15bf
PYTHON_GITDB2_SETUP_TYPE = setuptools
PYTHON_GITDB2_LICENSE = BSD-3-Clause
PYTHON_GITDB2_LICENSE_FILES = LICENSE

$(eval $(python-package))
