################################################################################
#
# python-aiodns
#
################################################################################

PYTHON_AIODNS_VERSION = 4.0.4
PYTHON_AIODNS_SOURCE = aiodns-$(PYTHON_AIODNS_VERSION).tar.gz
PYTHON_AIODNS_SITE = https://files.pythonhosted.org/packages/9b/22/a2d928e0e42baad0471d12ec44c71152ac870486e8298dddb2893b888c29
PYTHON_AIODNS_SETUP_TYPE = setuptools
PYTHON_AIODNS_LICENSE = MIT
PYTHON_AIODNS_LICENSE_FILES = LICENSE
PYTHON_AIODNS_BUILD_OPTS = --skip-dependency-check

$(eval $(python-package))
