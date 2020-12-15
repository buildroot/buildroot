################################################################################
#
# python-dnspython
#
################################################################################

PYTHON_DNSPYTHON_VERSION = 2.0.0
PYTHON_DNSPYTHON_SOURCE = dnspython-$(PYTHON_DNSPYTHON_VERSION).zip
PYTHON_DNSPYTHON_SITE = https://files.pythonhosted.org/packages/67/d0/639a9b5273103a18c5c68a7a9fc02b01cffa3403e72d553acec444f85d5b
PYTHON_DNSPYTHON_LICENSE = ISC
PYTHON_DNSPYTHON_LICENSE_FILES = LICENSE
PYTHON_DNSPYTHON_SETUP_TYPE = setuptools

define PYTHON_DNSPYTHON_EXTRACT_CMDS
	$(UNZIP) -d $(@D) $(PYTHON_DNSPYTHON_DL_DIR)/$(PYTHON_DNSPYTHON_SOURCE)
	mv $(@D)/dnspython-$(PYTHON_DNSPYTHON_VERSION)/* $(@D)
	$(RM) -r $(@D)/dnspython-$(PYTHON_DNSPYTHON_VERSION)
endef

$(eval $(python-package))
