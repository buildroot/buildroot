################################################################################
#
# python-colorlog
#
################################################################################

PYTHON_COLORLOG_VERSION = 6.9.0
PYTHON_COLORLOG_SOURCE = colorlog-$(PYTHON_COLORLOG_VERSION).tar.gz
PYTHON_COLORLOG_SITE = https://files.pythonhosted.org/packages/d3/7a/359f4d5df2353f26172b3cc39ea32daa39af8de522205f512f458923e677
PYTHON_COLORLOG_SETUP_TYPE = setuptools
PYTHON_COLORLOG_LICENSE = MIT
PYTHON_COLORLOG_LICENSE_FILES = LICENSE

$(eval $(python-package))
