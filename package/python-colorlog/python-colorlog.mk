################################################################################
#
# python-colorlog
#
################################################################################

PYTHON_COLORLOG_VERSION = 6.12.0
PYTHON_COLORLOG_SOURCE = colorlog-$(PYTHON_COLORLOG_VERSION).tar.gz
PYTHON_COLORLOG_SITE = https://files.pythonhosted.org/packages/8c/55/ba79756cb90c8d69d599d57785398ac87bba7b19c80e87f4e8a562197c93
PYTHON_COLORLOG_SETUP_TYPE = setuptools
PYTHON_COLORLOG_LICENSE = MIT
PYTHON_COLORLOG_LICENSE_FILES = LICENSE

$(eval $(python-package))
