################################################################################
#
# python-setuptools-scm-git-archive
#
################################################################################

PYTHON_SETUPTOOLS_SCM_GIT_ARCHIVE_VERSION = 1.4
PYTHON_SETUPTOOLS_SCM_GIT_ARCHIVE_SOURCE = setuptools_scm_git_archive-$(PYTHON_SETUPTOOLS_SCM_GIT_ARCHIVE_VERSION).tar.gz
PYTHON_SETUPTOOLS_SCM_GIT_ARCHIVE_SITE = https://files.pythonhosted.org/packages/69/5f/7135eec07395c51d3dd6899251b277405ecc2f8f7a80ef80a483e3c5a2bd
PYTHON_SETUPTOOLS_SCM_GIT_ARCHIVE_SETUP_TYPE = setuptools
PYTHON_SETUPTOOLS_SCM_GIT_ARCHIVE_LICENSE = MIT
PYTHON_SETUPTOOLS_SCM_GIT_ARCHIVE_LICENSE_FILES = LICENSE
HOST_PYTHON_SETUPTOOLS_SCM_GIT_ARCHIVE_DEPENDENCIES = host-python-setuptools-scm

$(eval $(host-python-package))
