################################################################################
#
# python-setuptools-scm-git-archive
#
################################################################################

PYTHON_SETUPTOOLS_SCM_GIT_ARCHIVE_VERSION = 1.4.1
PYTHON_SETUPTOOLS_SCM_GIT_ARCHIVE_SOURCE = setuptools_scm_git_archive-$(PYTHON_SETUPTOOLS_SCM_GIT_ARCHIVE_VERSION).tar.gz
PYTHON_SETUPTOOLS_SCM_GIT_ARCHIVE_SITE = https://files.pythonhosted.org/packages/47/d6/c9a8d1ea95613f79b9b914cf9a5e8e420b7625fc54137c1d7c9cbbda5adf
PYTHON_SETUPTOOLS_SCM_GIT_ARCHIVE_SETUP_TYPE = setuptools
PYTHON_SETUPTOOLS_SCM_GIT_ARCHIVE_LICENSE = MIT
PYTHON_SETUPTOOLS_SCM_GIT_ARCHIVE_LICENSE_FILES = LICENSE
HOST_PYTHON_SETUPTOOLS_SCM_GIT_ARCHIVE_DEPENDENCIES = host-python-setuptools-scm

$(eval $(host-python-package))
