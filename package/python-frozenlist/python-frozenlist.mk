################################################################################
#
# python-frozenlist
#
################################################################################

PYTHON_FROZENLIST_VERSION = 1.4.1
PYTHON_FROZENLIST_SOURCE = frozenlist-$(PYTHON_FROZENLIST_VERSION).tar.gz
PYTHON_FROZENLIST_SITE = https://files.pythonhosted.org/packages/cf/3d/2102257e7acad73efc4a0c306ad3953f68c504c16982bbdfee3ad75d8085
PYTHON_FROZENLIST_SETUP_TYPE = pep517
PYTHON_FROZENLIST_LICENSE = Apache-2.0
PYTHON_FROZENLIST_LICENSE_FILES = LICENSE
PYTHON_FROZENLIST_DEPENDENCIES = \
	host-python-expandvars \
	host-python-setuptools
# C code generation required Cython 3 which we don't have in Buildroot yet.
PYTHON_FROZENLIST_BUILD_OPTS = -C=pure-python=true

$(eval $(python-package))
