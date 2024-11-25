################################################################################
#
# python-more-itertools
#
################################################################################

PYTHON_MORE_ITERTOOLS_VERSION = 10.5.0
PYTHON_MORE_ITERTOOLS_SOURCE = more-itertools-$(PYTHON_MORE_ITERTOOLS_VERSION).tar.gz
PYTHON_MORE_ITERTOOLS_SITE = https://files.pythonhosted.org/packages/51/78/65922308c4248e0eb08ebcbe67c95d48615cc6f27854b6f2e57143e9178f
PYTHON_MORE_ITERTOOLS_SETUP_TYPE = flit
PYTHON_MORE_ITERTOOLS_LICENSE = MIT
PYTHON_MORE_ITERTOOLS_LICENSE_FILES = LICENSE

$(eval $(python-package))
