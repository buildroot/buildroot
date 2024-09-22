################################################################################
#
# python-zc-lockfile
#
################################################################################

PYTHON_ZC_LOCKFILE_VERSION = 3.0.post1
PYTHON_ZC_LOCKFILE_SOURCE = zc.lockfile-$(PYTHON_ZC_LOCKFILE_VERSION).tar.gz
PYTHON_ZC_LOCKFILE_SITE = https://files.pythonhosted.org/packages/5b/83/a5432aa08312fc834ea594473385c005525e6a80d768a2ad246e78877afd
PYTHON_ZC_LOCKFILE_SETUP_TYPE = setuptools
PYTHON_ZC_LOCKFILE_LICENSE = ZPL-2.1
PYTHON_ZC_LOCKFILE_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
