################################################################################
#
# python-dpkt
#
################################################################################

PYTHON_DPKT_VERSION = 1.9.7.2
PYTHON_DPKT_SOURCE = dpkt-$(PYTHON_DPKT_VERSION).tar.gz
PYTHON_DPKT_SITE = https://files.pythonhosted.org/packages/95/51/923b370880eff9b62fe4fe965a916da709022a02669c670731da69088e93
PYTHON_DPKT_SETUP_TYPE = setuptools
PYTHON_DPKT_LICENSE = BSD-3-Clause
PYTHON_DPKT_LICENSE_FILES = LICENSE

$(eval $(python-package))
