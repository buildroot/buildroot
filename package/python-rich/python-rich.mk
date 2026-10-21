################################################################################
#
# python-rich
#
################################################################################

PYTHON_RICH_VERSION = 15.0.0
PYTHON_RICH_SOURCE = rich-$(PYTHON_RICH_VERSION).tar.gz
PYTHON_RICH_SITE = https://files.pythonhosted.org/packages/c0/8f/0722ca900cc807c13a6a0c696dacf35430f72e0ec571c4275d2371fca3e9
PYTHON_RICH_SETUP_TYPE = poetry
PYTHON_RICH_LICENSE = MIT
PYTHON_RICH_LICENSE_FILES = LICENSE
HOST_PYTHON_RICH_DEPENDENCIES = host-python-markdown-it-py host-python-pygments

$(eval $(python-package))
$(eval $(host-python-package))
