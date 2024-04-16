################################################################################
#
# python-gitdb2
#
################################################################################

PYTHON_GITDB2_VERSION = 4.0.11
PYTHON_GITDB2_SOURCE = gitdb-$(PYTHON_GITDB2_VERSION).tar.gz
PYTHON_GITDB2_SITE = https://files.pythonhosted.org/packages/19/0d/bbb5b5ee188dec84647a4664f3e11b06ade2bde568dbd489d9d64adef8ed
PYTHON_GITDB2_SETUP_TYPE = setuptools
PYTHON_GITDB2_LICENSE = BSD-3-Clause
PYTHON_GITDB2_LICENSE_FILES = LICENSE

$(eval $(python-package))
