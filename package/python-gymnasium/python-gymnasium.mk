################################################################################
#
# python-gymnasium
#
################################################################################

PYTHON_GYMNASIUM_VERSION = 1.4.0
PYTHON_GYMNASIUM_SOURCE = gymnasium-$(PYTHON_GYMNASIUM_VERSION).tar.gz
PYTHON_GYMNASIUM_SITE = https://files.pythonhosted.org/packages/fb/3a/6713c8a92c259fd7619dc93ff19e6e435463f20d3d7b180b14ce99074c10
PYTHON_GYMNASIUM_SETUP_TYPE = setuptools
PYTHON_GYMNASIUM_LICENSE = MIT
PYTHON_GYMNASIUM_LICENSE_FILES = LICENSE

$(eval $(python-package))
