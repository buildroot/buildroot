################################################################################
#
# python-more-itertools
#
################################################################################

PYTHON_MORE_ITERTOOLS_VERSION = 10.1.0
PYTHON_MORE_ITERTOOLS_SOURCE = more-itertools-$(PYTHON_MORE_ITERTOOLS_VERSION).tar.gz
PYTHON_MORE_ITERTOOLS_SITE = https://files.pythonhosted.org/packages/2d/73/3557e45746fcaded71125c0a1c0f87616e8258c78391f0c365bf97bbfc99
PYTHON_MORE_ITERTOOLS_SETUP_TYPE = flit
PYTHON_MORE_ITERTOOLS_LICENSE = MIT
PYTHON_MORE_ITERTOOLS_LICENSE_FILES = LICENSE

$(eval $(python-package))
