################################################################################
#
# python-zc-lockfile
#
################################################################################

PYTHON_ZC_LOCKFILE_VERSION = 4.0
PYTHON_ZC_LOCKFILE_SOURCE = zc_lockfile-$(PYTHON_ZC_LOCKFILE_VERSION).tar.gz
PYTHON_ZC_LOCKFILE_SITE = https://files.pythonhosted.org/packages/10/9a/2fef89272d98b799e4daa50201c5582ec76bdd4e92a1a7e3deb74c52b7fa
PYTHON_ZC_LOCKFILE_SETUP_TYPE = setuptools
PYTHON_ZC_LOCKFILE_LICENSE = ZPL-2.1
PYTHON_ZC_LOCKFILE_LICENSE_FILES = LICENSE.txt
PYTHON_ZC_LOCKFILE_BUILD_OPTS = --skip-dependency-check

$(eval $(python-package))
