################################################################################
#
# python-can
#
################################################################################

PYTHON_CAN_VERSION = 4.6.1
PYTHON_CAN_SOURCE = python_can-$(PYTHON_CAN_VERSION).tar.gz
PYTHON_CAN_SITE = https://files.pythonhosted.org/packages/74/f9/a9d99d36dd33be5badb747801c9255c3c526171a5542092eaacc73350fb8
PYTHON_CAN_SETUP_TYPE = setuptools
PYTHON_CAN_LICENSE = LGPL-3.0
PYTHON_CAN_LICENSE_FILES = LICENSE.txt
PYTHON_CAN_DEPENDENCIES = host-python-setuptools-scm

ifneq ($(BR2_PACKAGE_PYTHON_CAN_VIEWER),y)
define PYTHON_CAN_REMOVE_VIEWER
	rm -f $(TARGET_DIR)/usr/lib/python$(PYTHON3_VERSION_MAJOR)/site-packages/can/viewer.py
endef
PYTHON_CAN_POST_INSTALL_TARGET_HOOKS += PYTHON_CAN_REMOVE_VIEWER
endif

$(eval $(python-package))
