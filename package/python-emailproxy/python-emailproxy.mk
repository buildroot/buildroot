################################################################################
#
# python-emailproxy
#
################################################################################

PYTHON_EMAILPROXY_VERSION = 2026.7.3
PYTHON_EMAILPROXY_SOURCE = emailproxy-$(PYTHON_EMAILPROXY_VERSION).tar.gz
PYTHON_EMAILPROXY_SITE = https://files.pythonhosted.org/packages/6e/bc/51b7adf9e9f176f838cf4649ed27584b88ca5a0c8650ca75e9b432c563e0
PYTHON_EMAILPROXY_SETUP_TYPE = setuptools
PYTHON_EMAILPROXY_LICENSE = Apache-2.0
PYTHON_EMAILPROXY_LICENSE_FILES = LICENSE

$(eval $(python-package))
