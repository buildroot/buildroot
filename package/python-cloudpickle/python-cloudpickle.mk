################################################################################
#
# python-cloudpickle
#
################################################################################

PYTHON_CLOUDPICKLE_VERSION = 3.1.2
PYTHON_CLOUDPICKLE_SOURCE = cloudpickle-$(PYTHON_CLOUDPICKLE_VERSION).tar.gz
PYTHON_CLOUDPICKLE_SITE = https://files.pythonhosted.org/packages/27/fb/576f067976d320f5f0114a8d9fa1215425441bb35627b1993e5afd8111e5
PYTHON_CLOUDPICKLE_SETUP_TYPE = flit
PYTHON_CLOUDPICKLE_LICENSE = BSD-3-Clause
PYTHON_CLOUDPICKLE_LICENSE_FILES = LICENSE

$(eval $(python-package))
