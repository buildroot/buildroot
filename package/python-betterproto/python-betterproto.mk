################################################################################
#
# python-betterproto
#
################################################################################

PYTHON_BETTERPROTO_VERSION = 2.0.0b7
PYTHON_BETTERPROTO_SOURCE = betterproto-$(PYTHON_BETTERPROTO_VERSION).tar.gz
PYTHON_BETTERPROTO_SITE = https://files.pythonhosted.org/packages/4e/94/930a1368fbed92adc897a9a1fae282e3f9d608547dbf805034ca549f381a
PYTHON_BETTERPROTO_SETUP_TYPE = poetry
PYTHON_BETTERPROTO_LICENSE = MIT
PYTHON_BETTERPROTO_LICENSE_FILES = LICENSE.md
PYTHON_BETTERPROTO_BUILD_OPTS = --skip-dependency-check

$(eval $(python-package))
