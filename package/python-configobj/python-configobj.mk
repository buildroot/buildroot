################################################################################
#
# python-configobj
#
################################################################################

PYTHON_CONFIGOBJ_VERSION = v5.0.6
PYTHON_CONFIGOBJ_SOURCE = $(PYTHON_CONFIGOBJ_VERSION).tar.gz
PYTHON_CONFIGOBJ_SITE = $(call github,diffsk,configobj,$(PYTHON_CONFIGOBJ_VERSION))
PYTHON_CONFIGOBJ_LICENSE = BSD-3-Clause
PYTHON_CONFIGOBJ_LICENSE_FILES = LICENSE
PYTHON_CONFIGOBJ_SETUP_TYPE = distutils

$(eval $(python-package))
