################################################################################
#
# python-more-itertools
#
################################################################################

PYTHON_MORE_ITERTOOLS_VERSION = 9.0.0
PYTHON_MORE_ITERTOOLS_SOURCE = more-itertools-$(PYTHON_MORE_ITERTOOLS_VERSION).tar.gz
PYTHON_MORE_ITERTOOLS_SITE = https://files.pythonhosted.org/packages/13/b3/397aa9668da8b1f0c307bc474608653d46122ae0563d1d32f60e24fa0cbd
PYTHON_MORE_ITERTOOLS_SETUP_TYPE = flit
PYTHON_MORE_ITERTOOLS_LICENSE = MIT
PYTHON_MORE_ITERTOOLS_LICENSE_FILES = LICENSE

$(eval $(python-package))
