################################################################################
#
# python-colorlog
#
################################################################################

PYTHON_COLORLOG_VERSION = 4.7.2
PYTHON_COLORLOG_SOURCE = colorlog-$(PYTHON_COLORLOG_VERSION).tar.gz
PYTHON_COLORLOG_SITE = https://files.pythonhosted.org/packages/b2/d8/7bd0e6aa6b7dc93611f90a847eefcd048d3cae66dc8867c72486362bdfbd
PYTHON_COLORLOG_SETUP_TYPE = setuptools
PYTHON_COLORLOG_LICENSE = MIT
PYTHON_COLORLOG_LICENSE_FILES = LICENSE

$(eval $(python-package))
