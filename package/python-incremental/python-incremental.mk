################################################################################
#
# python-incremental
#
################################################################################

PYTHON_INCREMENTAL_VERSION = 22.10.0
PYTHON_INCREMENTAL_SOURCE = incremental-$(PYTHON_INCREMENTAL_VERSION).tar.gz
PYTHON_INCREMENTAL_SITE = https://files.pythonhosted.org/packages/86/42/9e87f04fa2cd40e3016f27a4b4572290e95899c6dce317e2cdb580f3ff09
PYTHON_INCREMENTAL_SETUP_TYPE = setuptools
PYTHON_INCREMENTAL_LICENSE = MIT
PYTHON_INCREMENTAL_LICENSE_FILES = LICENSE

$(eval $(python-package))
$(eval $(host-python-package))
