################################################################################
#
# python-incremental
#
################################################################################

PYTHON_INCREMENTAL_VERSION = 21.3.0
PYTHON_INCREMENTAL_SOURCE = incremental-$(PYTHON_INCREMENTAL_VERSION).tar.gz
PYTHON_INCREMENTAL_SITE = https://files.pythonhosted.org/packages/4f/c5/430765c697afc217c8491785de321a21fa4d983dda14bcd82feb965b0593
PYTHON_INCREMENTAL_SETUP_TYPE = setuptools
PYTHON_INCREMENTAL_LICENSE = MIT
PYTHON_INCREMENTAL_LICENSE_FILES = LICENSE

$(eval $(python-package))
$(eval $(host-python-package))
