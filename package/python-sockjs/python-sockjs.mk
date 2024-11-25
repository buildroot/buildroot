################################################################################
#
# python-sockjs
#
################################################################################

PYTHON_SOCKJS_VERSION = 0.13.0
PYTHON_SOCKJS_SOURCE = sockjs-$(PYTHON_SOCKJS_VERSION).tar.gz
PYTHON_SOCKJS_SITE = https://files.pythonhosted.org/packages/00/a4/644d5901d51aecb9fff218bbfc2525ef9362d4d03c2fcb8cb322aa0ce77f
PYTHON_SOCKJS_SETUP_TYPE = setuptools
PYTHON_SOCKJS_LICENSE = Apache-2.0
PYTHON_SOCKJS_LICENSE_FILES = LICENSE

$(eval $(python-package))
