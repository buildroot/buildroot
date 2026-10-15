################################################################################
#
# python-entrypoints
#
################################################################################

PYTHON_ENTRYPOINTS_VERSION = 0.4.2
PYTHON_ENTRYPOINTS_SOURCE = entrypoints-$(PYTHON_ENTRYPOINTS_VERSION).tar.gz
PYTHON_ENTRYPOINTS_SITE = https://files.pythonhosted.org/packages/9a/6d/8f96c1eb3aa1b448a718866e88e0201145a35e80ffcee3b1b88543d3e740
PYTHON_ENTRYPOINTS_SETUP_TYPE = flit
PYTHON_ENTRYPOINTS_LICENSE = MIT
PYTHON_ENTRYPOINTS_LICENSE_FILES = LICENSE

$(eval $(python-package))
