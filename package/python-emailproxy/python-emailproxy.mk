################################################################################
#
# python-emailproxy
#
################################################################################

PYTHON_EMAILPROXY_VERSION = 2025.6.25
PYTHON_EMAILPROXY_SOURCE = emailproxy-$(PYTHON_EMAILPROXY_VERSION).tar.gz
PYTHON_EMAILPROXY_SITE = https://files.pythonhosted.org/packages/a4/85/c9266b2457f018783dc0149e123bad115e02d0bd01f7c2a5aa61715250f1
PYTHON_EMAILPROXY_SETUP_TYPE = setuptools
PYTHON_EMAILPROXY_LICENSE = Apache-2.0
PYTHON_EMAILPROXY_LICENSE_FILES = LICENSE

$(eval $(python-package))
