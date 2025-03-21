################################################################################
#
# python-emailproxy
#
################################################################################

PYTHON_EMAILPROXY_VERSION = 2025.3.14
PYTHON_EMAILPROXY_SOURCE = emailproxy-$(PYTHON_EMAILPROXY_VERSION).tar.gz
PYTHON_EMAILPROXY_SITE = https://files.pythonhosted.org/packages/15/b9/b2864ab1da9fdf7409589de99501b227352c9a6b8fa1178660debf0a2ad6
PYTHON_EMAILPROXY_SETUP_TYPE = setuptools
PYTHON_EMAILPROXY_LICENSE = Apache-2.0
PYTHON_EMAILPROXY_LICENSE_FILES = LICENSE

$(eval $(python-package))
