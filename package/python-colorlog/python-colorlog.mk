################################################################################
#
# python-colorlog
#
################################################################################

PYTHON_COLORLOG_VERSION = 6.7.0
PYTHON_COLORLOG_SOURCE = colorlog-$(PYTHON_COLORLOG_VERSION).tar.gz
PYTHON_COLORLOG_SITE = https://files.pythonhosted.org/packages/78/6b/4e5481ddcdb9c255b2715f54c863629f1543e97bc8c309d1c5c131ad14f2
PYTHON_COLORLOG_SETUP_TYPE = setuptools
PYTHON_COLORLOG_LICENSE = MIT
PYTHON_COLORLOG_LICENSE_FILES = LICENSE

$(eval $(python-package))
