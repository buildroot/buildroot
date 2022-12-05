################################################################################
#
# python-dpkt
#
################################################################################

PYTHON_DPKT_VERSION = 1.9.8
PYTHON_DPKT_SOURCE = dpkt-$(PYTHON_DPKT_VERSION).tar.gz
PYTHON_DPKT_SITE = https://files.pythonhosted.org/packages/c9/7d/52f17a794db52a66e46ebb0c7549bf2f035ed61d5a920ba4aaa127dd038e
PYTHON_DPKT_SETUP_TYPE = setuptools
PYTHON_DPKT_LICENSE = BSD-3-Clause
PYTHON_DPKT_LICENSE_FILES = LICENSE

$(eval $(python-package))
