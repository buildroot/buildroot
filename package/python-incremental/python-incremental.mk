################################################################################
#
# python-incremental
#
################################################################################

PYTHON_INCREMENTAL_VERSION = 24.7.2
PYTHON_INCREMENTAL_SOURCE = incremental-$(PYTHON_INCREMENTAL_VERSION).tar.gz
PYTHON_INCREMENTAL_SITE = https://files.pythonhosted.org/packages/27/87/156b374ff6578062965afe30cc57627d35234369b3336cf244b240c8d8e6
PYTHON_INCREMENTAL_SETUP_TYPE = setuptools
PYTHON_INCREMENTAL_LICENSE = MIT
PYTHON_INCREMENTAL_LICENSE_FILES = LICENSE

$(eval $(python-package))
$(eval $(host-python-package))
