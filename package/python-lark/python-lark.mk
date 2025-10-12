################################################################################
#
# python-lark
#
################################################################################

PYTHON_LARK_VERSION = 1.3.0
PYTHON_LARK_SOURCE = lark-$(PYTHON_LARK_VERSION).tar.gz
PYTHON_LARK_SITE = https://files.pythonhosted.org/packages/1d/37/a13baf0135f348af608c667633cbe5d13aa2c5c15a56ae9ad3e6cba45ae3
PYTHON_LARK_SETUP_TYPE = setuptools
PYTHON_LARK_LICENSE = MIT
PYTHON_LARK_LICENSE_FILES = LICENSE

$(eval $(python-package))
