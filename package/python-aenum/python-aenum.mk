################################################################################
#
# python-aenum
#
################################################################################

PYTHON_AENUM_VERSION = 3.1.0
PYTHON_AENUM_SOURCE = aenum-$(PYTHON_AENUM_VERSION).tar.gz
PYTHON_AENUM_SITE = https://files.pythonhosted.org/packages/ae/25/00b2949186e76a4c9732e33221274964fecf5c88178cbe5a14a80cfc04e8
PYTHON_AENUM_SETUP_TYPE = setuptools
PYTHON_AENUM_LICENSE = BSD-3-Clause
PYTHON_AENUM_LICENSE_FILES = aenum/LICENSE

ifeq ($(BR2_PACKAGE_PYTHON),y)
# only needed/valid for python 3.x
define PYTHON_AENUM_RM_PY3_FILE
	rm -f $(TARGET_DIR)/usr/lib/python*/site-packages/aenum/test_v3.py
endef

PYTHON_AENUM_POST_INSTALL_TARGET_HOOKS += PYTHON_AENUM_RM_PY3_FILE
endif

$(eval $(python-package))
