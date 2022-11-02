################################################################################
#
# python-entrypoints
#
################################################################################

PYTHON_ENTRYPOINTS_VERSION = 0.4
PYTHON_ENTRYPOINTS_SOURCE = entrypoints-$(PYTHON_ENTRYPOINTS_VERSION).tar.gz
PYTHON_ENTRYPOINTS_SITE = https://files.pythonhosted.org/packages/ea/8d/a7121ffe5f402dc015277d2d31eb82d2187334503a011c18f2e78ecbb9b2
PYTHON_ENTRYPOINTS_SETUP_TYPE = flit
PYTHON_ENTRYPOINTS_LICENSE = MIT
PYTHON_ENTRYPOINTS_LICENSE_FILES = LICENSE

$(eval $(python-package))
