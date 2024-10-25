################################################################################
#
# python-frozenlist
#
################################################################################

PYTHON_FROZENLIST_VERSION = 1.5.0
PYTHON_FROZENLIST_SOURCE = frozenlist-$(PYTHON_FROZENLIST_VERSION).tar.gz
PYTHON_FROZENLIST_SITE = https://files.pythonhosted.org/packages/8f/ed/0f4cec13a93c02c47ec32d81d11c0c1efbadf4a471e3f3ce7cad366cbbd3
PYTHON_FROZENLIST_SETUP_TYPE = pep517
PYTHON_FROZENLIST_LICENSE = Apache-2.0
PYTHON_FROZENLIST_LICENSE_FILES = LICENSE
PYTHON_FROZENLIST_DEPENDENCIES = \
	host-python-expandvars \
	host-python-setuptools
# C code generation required Cython 3 which we don't have in Buildroot yet.
PYTHON_FROZENLIST_BUILD_OPTS = -C=pure-python=true

$(eval $(python-package))
